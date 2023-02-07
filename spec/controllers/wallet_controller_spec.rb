# frozen_string_literal: true

require 'rails_helper'

describe WalletController do
  let(:user) { create(:user) }

  describe 'GET nfts' do
    it 'requires authentication' do
      get :nfts
      expect(response).to redirect_to('/')
    end

    it 'returns wallet nfts' do
      page = {
        page_number: 1,
        has_previous_page: false,
        has_next_page: true,
        next_cursor: 'cursor',
        data: [build(:dante)]
      }

      allow(controller).to receive(:get_wallet_nfts).and_return(page)

      get :nfts, session: { user_id: user.id }

      expect(response).to have_http_status(:success)
      expect(assigns(:page)).to eq(page.merge!(previous_cursor: nil))
    end
  end
end
