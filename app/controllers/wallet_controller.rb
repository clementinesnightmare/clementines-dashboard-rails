# frozen_string_literal: true

# Manages user wallet actions
class WalletController < ApplicationController
  before_action :authenticate_user

  def nfts
    @page = get_wallet_nfts(current_user.eth_address, 24, wallet_params[:cursor])

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def wallet_params
    params.permit(:cursor)
  end
end
