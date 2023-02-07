# frozen_string_literal: true

# Manages vault actions
class VaultController < ApplicationController
  before_action :authenticate_user

  def nfts
    @page = get_vault_nfts(100, vault_params[:cursor])

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def vault_params
    params.permit(:cursor)
  end
end
