# frozen_string_literal: true

# The Nft model represents a user's NFT or a vault NFT. It is not persistent.
class Nft
  attr_accessor :token_address, :token_id, :owner_of, :name, :image_url, :animation_url,
                :url

  CONTRACT_ADDRESS_GENESIS_DOWNCASE = Rails.configuration.clem_config['CONTRACT_ADDRESS_GENESIS'].downcase.freeze

  CONTRACT_ADDRESS_ECLIPSE_DOWNCASE = Rails.configuration.clem_config['CONTRACT_ADDRESS_ECLIPSE'].downcase.freeze

  CLEMENTINE_CONTRACT_ADDRESSES_DOWNCASE = [
    CONTRACT_ADDRESS_GENESIS_DOWNCASE,
    CONTRACT_ADDRESS_ECLIPSE_DOWNCASE
  ].freeze

  MARKETPLACE_URL = 'https://opensea.io'

  # @return [Nft] Nft instance created from
  # Moralis data.
  def self.from_moralis(moralis_hash)
    nft = Nft.new

    nft.token_address = moralis_hash['token_address']
    nft.token_id = moralis_hash['token_id'].to_i
    nft.owner_of = moralis_hash['owner_of']

    metadata = moralis_hash['normalized_metadata']
    nft.name = metadata['name']
    nft.image_url = metadata['image'] || metadata['image_url']
    nft.animation_url = metadata['animation_url']

    ipfs_replacement = nft.clem? ? 'https://clementinesnightmare.mypinata.cloud/ipfs/' : 'https://ipfs.io/ipfs/'
    nft.url = (nft.image_url || nft.animation_url).sub('ipfs://', ipfs_replacement)

    nft
  end

  # @return [Boolean] if this is a Clementine's Nightmare collection NFT
  def clem?
    CLEMENTINE_CONTRACT_ADDRESSES_DOWNCASE.include?(token_address.downcase)
  end

  # @return [Boolean] if this is a Clementine's Nightmare Genesis collection NFT
  def genesis?
    token_address.downcase == CONTRACT_ADDRESS_GENESIS_DOWNCASE
  end

  # @return [Boolean] if this is a Clementine's Nightmare Eclipse collection NFT
  def eclipse?
    token_address.downcase == CONTRACT_ADDRESS_ECLIPSE_DOWNCASE
  end

  # @return [Boolean] for Clementine's Nightmare Genesis collection returns whether
  # it is an ultra legendary NFT. Returns false for other collections.
  def ultra_legendary?
    if eclipse?
      Rails.configuration.clem_config['ULTRA_LEGENDS_ECLIPSE'].include?(token_id)
    elsif genesis?
      Rails.configuration.clem_config['ULTRA_LEGENDS_GENESIS'].include?(token_id)
    end
  end

  # @return [Boolean] for Clementine's Nightmare Genesis collection returns whether
  # it is a legendary NFT. Returns false for other collections.
  def legendary?
    if eclipse?
      Rails.configuration.clem_config['LEGENDS_ECLIPSE'].include?(token_id)
    elsif genesis?
      Rails.configuration.clem_config['LEGENDS_GENESIS'].include?(token_id)
    end
  end

  # @return [Boolean] for Clementine's Nightmare Genesis collection returns whether
  # it is a rare NFT. Returns false for other collections.
  def rare?
    if eclipse?
      Rails.configuration.clem_config['RARES_ECLIPSE'].include?(token_id)
    elsif genesis?
      Rails.configuration.clem_config['RARES_GENESIS'].include?(token_id)
    end
  end

  # @return [Boolean] if the NFT is an mp4 video.
  def video?
    url.downcase.include?('.mp4')
  end

  # @return [String] Marketplace URL for the NFT.
  def marketplace_url
    "#{MARKETPLACE_URL}/assets/#{token_address}/#{token_id}"
  end
end
