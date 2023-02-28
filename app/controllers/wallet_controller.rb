# frozen_string_literal: true

# Manages user wallet actions
class WalletController < ApplicationController
  before_action :authenticate_user, except: :public_nfts

  def nfts
    @page = get_wallet_nfts(current_user.eth_address, 24, wallet_params[:cursor])

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def public_nfts
    user = User.find_by(username: public_profile_nfts_params[:username])
    raise ActionController::RoutingError, 'Not Found' if !user || !user.public_profile

    @page = get_wallet_nfts(user.eth_address, 24, wallet_params[:cursor])

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

  def public_profile_nfts_params
    params.permit(:username, :cursor)
  end
end
