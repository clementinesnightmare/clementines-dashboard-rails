# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    eth_address { Eth::Key.new.address }
    username { "#{Faker::Name.unique.first_name}_#{Faker::Name.unique.last_name}" }
    eth_nonce { SecureRandom.uuid }
  end
end
