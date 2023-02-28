# frozen_string_literal: true

# Root controller
class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_page_metadata

  private

  def set_page_metadata
    @load_eth_js = !logged_in?
  end

  # Helper method for controllers to
  # render 404 page.
  def render_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end
end
