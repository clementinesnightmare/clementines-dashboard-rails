# frozen_string_literal: true

# Helper to fetch NFT data using the Moralis APIs
class MoralisIndexer
  class RequestFailed < StandardError; end

  MORALIS_URL = 'https://deep-index.moralis.io/api/v2'

  # rubocop:disable Metrics/AbcSize
  # Skips NFTs with missing metadata and
  # those with names in NftIndexer::SKIPPED_NFT_NAMES list.
  def get_nfts(wallet_address, contract_addresses, limit, cursor)
    # TODO: validate params
    url = "#{MORALIS_URL}/#{wallet_address}/nft"
    params = {
      chain: 'eth',
      format: 'decimal',
      limit: limit,
      cursor: cursor,
      disable_total: true,
      normalizeMetadata: true
    }
    params[:token_addresses] = contract_addresses if contract_addresses.present?

    response = connection.get(url, params)
    raise RequestFailed, 'Something went wrong when fetching NFT data' unless response.success?

    result = (response.body['result'] || []).reject do |moralis_hash|
      moralis_hash['metadata'].blank? || NftIndexer::NFT_SKIP_LIST.include?(moralis_hash['normalized_metadata']['name'])
    end

    nfts = result.map { |moralis_hash| Nft.from_moralis(moralis_hash) }

    {
      page_number: response.body['page'],
      has_previous_page: response.body['page'] > 1,
      has_next_page: response.body['cursor'].present?,
      next_cursor: response.body['cursor'],
      data: nfts
    }
  end
  # rubocop:enable Metrics/AbcSize

  # TODO: enable retry? https://lostisland.github.io/faraday/usage/
  # TODO: add timeout? https://lostisland.github.io/faraday/usage/customize
  #
  def connection
    return @connection if @connection.present?

    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-API-Key' => ENV['MORALIS_API_KEY']
    }

    @connection = Faraday.new(url: MORALIS_URL, headers: headers) do |f|
      f.response :json
    end
  end
end
