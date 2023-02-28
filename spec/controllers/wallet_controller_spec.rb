# frozen_string_literal: true

require 'rails_helper'

describe WalletController do
  let(:user) { create(:user) }
  let(:page) do
    {
      page_number: 1,
      has_previous_page: false,
      has_next_page: true,
      next_cursor: 'cursor',
      data: [build(:dante)]
    }
  end

  describe 'GET nfts' do
    it 'requires authentication' do
      get :nfts
      expect(response).to redirect_to('/')
    end

    it 'returns wallet nfts' do
      allow(controller).to receive(:get_wallet_nfts).and_return(page)
      get :nfts, session: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:page)).to eq(page.merge!(previous_cursor: nil))
    end
  end

  describe 'public_nfts' do
    context 'when profile is private' do
      it 'causes routing error' do
        expect do
          get :public_nfts, params: { username: user.username }
        end.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when profile is public' do
      it 'renders successfully' do
        user.public_profile = true
        user.save!

        allow(controller).to receive(:get_wallet_nfts).and_return(page)
        get :public_nfts, params: { username: user.username }
        expect(response).to have_http_status(:success)
        expect(assigns(:page)).to eq(page.merge!(previous_cursor: nil))
      end
    end
  end
end
