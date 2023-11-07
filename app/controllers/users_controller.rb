# frozen_string_literal: true

# Manages interactions with the user model
class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[nonce public_profile]
  before_action :set_profile_metadata, only: %i[profile edit_profile update_profile public_profile]

  # GET /profile
  def profile; end

  # GET /profile/public
  def public_profile
    @user = User.find_by(username: public_profile_params[:username], public_profile: true)
  end

  # GET /profile/edit
  def edit_profile; end

  # PATCH/PUT /profile
  def update_profile
    if current_user.update(profile_params)
      redirect_to profile_path
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  # GET /users/:address/nonce
  def nonce
    params_address = Eth::Address.new user_params[:address]
    return unless params_address.valid?

    user = User.find_or_create_by!(eth_address: user_params[:address].downcase)
    render json: [eth_nonce: user.eth_nonce]
  end

  private

  def set_profile_metadata
    @screen_css_prefix = 'profile-'
    @page_title = if action_name == 'public_profile'
                    "#{public_profile_params[:username]} | Clementine's Nightmare Dashboard"
                  else
                    "Profile | Clementine's Nightmare Dashboard"
                  end
    @page_description = "User profile for Clementine's Nightmare Dashboard"
    @page_image_asset = ''
  end

  def user_params
    params.permit(:address)
  end

  def profile_params
    params.require(:user).permit(:username, :twitter_username, :discord_username, :public_profile)
  end

  def public_profile_params
    params.permit(:username)
  end
end
