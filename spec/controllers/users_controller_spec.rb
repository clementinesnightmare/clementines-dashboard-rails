# frozen_string_literal: true

require 'rails_helper'

describe UsersController do
  describe 'GET profile' do
    it 'requires authentication' do
      get :profile
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET edit_profile' do
    it 'requires authentication' do
      get :edit_profile
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET update_profile' do
    it 'requires authentication' do
      get :update_profile
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET public_profile' do
    context 'when profile is private' do
      it 'renders 404' do
        user = create(:user)
        get :public_profile, params: { username: user.username }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when profile is public' do
      it 'renders successfully' do
        user = create(:user, public_profile: true)
        get :public_profile, params: { username: user.username }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
