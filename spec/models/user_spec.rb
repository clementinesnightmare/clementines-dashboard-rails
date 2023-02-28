# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe '#save' do
    it 'downcases eth address before saving' do
      user.eth_address = 'QyZ1234'
      expect(user.save).to be(true)
      expect(user.eth_address).to eq('qyz1234')
    end

    it 'requires eth address' do
      user.eth_address = ''
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(['Eth address can\'t be blank'])
    end

    it 'requires address to be unique' do
      user.save!
      user2 = build(:user, eth_address: user.eth_address)
      expect(user2.save).to be(false)
      expect(user2.errors.map(&:full_message)).to match_array(['Eth address has already been taken'])
    end

    it 'requires nonce' do
      user.eth_nonce = ''
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(['Eth nonce can\'t be blank'])
    end

    it 'requires nonce to be unique' do
      user.save!
      user2 = build(:user, eth_nonce: user.eth_nonce)
      expect(user2.save).to be(false)
      expect(user2.errors.map(&:full_message)).to match_array(['Eth nonce has already been taken'])
    end

    it 'defaults username to eth address' do
      user.username = nil
      user.save!
      expect(user.username).to eq(user.reload.eth_address)
    end

    it 'does not override username with eth address' do
      user.username = 'user1'
      user.save!
      expect(user.username).to eq('user1')
    end

    it 'requires username' do
      user.eth_address = nil
      user.username = nil
      expect(user.save).to be_falsey
      expect(user.errors.map(&:full_message)).to include('Username can\'t be blank')
    end

    it 'requires username to be unique' do
      user.save!
      user2 = build(:user, username: user.username)
      expect(user2.save).to be(false)
      expect(user2.errors.map(&:full_message)).to match_array(['Username has already been taken'])
    end

    it 'requires username to contain only alphanumeric characters, hyphens and underscores' do
      user.username = '12ab!'
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(
        ['Username should contain only letters, numbers, hyphens and underscores']
      )
    end

    it 'requires username to be at most 32 characters long' do
      user.username = 'a' * 43
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(['Username is too long (maximum is 42 characters)'])
    end

    it 'disables public_profile by default' do
      user.save
      expect(user.public_profile).to be_falsey

      user.public_profile = true
      user.save
      expect(user.public_profile).to be_truthy
    end
  end
end
