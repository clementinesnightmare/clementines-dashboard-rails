# frozen_string_literal: true

# User model
class User < ApplicationRecord
  TWITTER_URL = 'https://twitter.com'
  DISCORD_USER_URL = 'https://discordapp.com/users'

  validates :eth_address, presence: true, uniqueness: true
  attribute :eth_nonce, :string, default: -> { SecureRandom.uuid }
  validates :eth_nonce, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { maximum: 42 },
                       format: {
                         with: /\A[a-zA-Z0-9-_]+\z/,
                         message: 'should contain only letters, numbers, hyphens and underscores'
                       }

  before_validation { default_username }
  before_save { downcase_eth_address }

  def twitter_url
    "#{TWITTER_URL}/#{twitter_username}"
  end

  def discord_url
    "#{DISCORD_USER_URL}/#{discord_username}"
  end

  private

  def downcase_eth_address
    eth_address&.downcase!
  end

  def default_username
    self.username = eth_address&.downcase if username.blank?
  end
end
