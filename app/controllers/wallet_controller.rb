# frozen_string_literal: true

# Manages user wallet actions
class WalletController < ApplicationController
  before_action :authenticate_user

  def nfts
    @page = get_wallet_nfts(current_user.eth_address, 10, wallet_params[:cursor])
    page_number = @page[:page_number]
    session[:wallet_pages] = {} if page_number == 1
    session[:wallet_pages][page_number.to_s] = wallet_params[:cursor]
    @page[:previous_cursor] = page_number > 1 ? session[:wallet_pages][(page_number - 1).to_s] : nil
  end

  private

  # Only allow a list of trusted parameters through.
  def wallet_params
    params.permit(:cursor)
  end
end
