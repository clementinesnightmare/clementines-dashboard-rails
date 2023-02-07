# frozen_string_literal: true

# Home page controller
class HomeController < ApplicationController
  # GET /
  def index
    @screen_css_prefix = 'home-'
    @page_title = "Clementine's Nightmare Dashboard"
    @page_description = "Dashboard for Clementine's Nightmare!"
    @page_image_asset = ''
    @load_eth_js = !logged_in?
  end
end
