# frozen_string_literal: true

# Helper module for profile controller and views.
module ProfileHelper
  CLEM_TWITTER_USERNAME = 'ClementinesGame'

  def profile_tweet_url(user)
    profile_page = public_profile_url(user.username)
    "http://www.twitter.com/share?url=#{ERB::Util.url_encode(profile_page)}&text=#{profile_tweet_text}&via=#{CLEM_TWITTER_USERNAME}&hashtags=ClementinesGame"
  end

  private

  def profile_tweet_text
    "Check out my Clementine's Nightmare profile!"
  end
end
