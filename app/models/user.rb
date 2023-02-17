# frozen_string_literal: true

# User model
class User < ApplicationRecord
  validates :eth_address, presence: true, uniqueness: true
  validates :eth_nonce, presence: true, uniqueness: true
  validates :lunch_money, numericality: { greater_than_or_equal_to: 0 }
  attribute :eth_nonce, :string, default: -> { SecureRandom.uuid }

  before_save { downcase_eth_address }

  private

  def downcase_eth_address
    eth_address&.downcase!
  end
end
