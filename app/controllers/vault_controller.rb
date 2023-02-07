# frozen_string_literal: true

# Manages vault actions
class VaultController < ApplicationController
  before_action :authenticate_user

  def nfts
    @page = get_vault_nfts(100, vault_params[:cursor])
    page_number = @page[:page_number]

    if page_number
      session[:vault_pages] = {} if page_number == 1
      session[:vault_pages][page_number.to_s] = vault_params[:cursor]
      @page[:previous_cursor] = page_number > 1 ? session[:vault_pages][(page_number - 1).to_s] : nil
    end

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
