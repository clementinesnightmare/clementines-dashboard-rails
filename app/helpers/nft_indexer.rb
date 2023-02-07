# frozen_string_literal: true

# rubocop:disable Rails/HelperInstanceVariable

# Helper to fetch NFT data.
module NftIndexer
  class RequestFailed < StandardError; end

  # TODO: Use contract address + token IDs instead?
  # List of NFTs to ignore.
  NFT_SKIP_LIST = [
    'Witch #253',
    'pixelatedink.eth',
    'clementinesnightmare.eth',
    'Spinal Foxes',
    'Witcher Mint Pass'
  ].freeze

  def get_wallet_nfts(wallet_address, limit, cursor)
    indexer.get_nfts(
      wallet_address,
      [
        Rails.configuration.clem_config['CONTRACT_ADDRESS_GENESIS'],
        Rails.configuration.clem_config['CONTRACT_ADDRESS_ECLIPSE']
      ],
      limit,
      cursor
    )
  end

  def get_vault_nfts(limit, cursor)
    indexer.get_nfts(
      Rails.configuration.clem_config['VAULT_ADDRESS'],
      nil,
      limit,
      cursor
    )
  end

  def indexer
    @indexer || MoralisIndexer.new
  end
end

# rubocop:enable Rails/HelperInstanceVariable
