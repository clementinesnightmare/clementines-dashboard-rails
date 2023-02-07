# frozen_string_literal: true

FactoryBot.define do
  factory :nft do
    owner_of { Eth::Key.new.address }

    factory :morde, aliases: [:genesis] do
      token_address { Rails.configuration.clem_config['CONTRACT_ADDRESS_GENESIS'] }
      token_id { 4920 }
      name { 'Morde #4920' }
      image_url { 'ipfs://QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/4920.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/ipfs/QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/4920.png' }
    end

    factory :dante, aliases: [:eclipse] do
      token_address { Rails.configuration.clem_config['CONTRACT_ADDRESS_ECLIPSE'] }
      token_id { 9935 }
      name { 'Dante #9935' }
      image_url { 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9935.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/ipfs/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9935.png' }
    end

    factory :roux_atome do
      token_address { Rails.configuration.clem_config['CONTRACT_ADDRESS_ECLIPSE'] }
      token_id { 9916 }
      name { 'Roux Atome #9916' }
      image_url { 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9916.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/ipfs/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9916.png' }
    end

    factory :genesis_ultra_legendary do
      token_address { '0x5c3cc8d8f5c2186d07d0bd9e5b463dca507b1708' }
      token_id { 47 }
      name { 'Kage' }
      animation_url { 'ipfs://QmSeMiDdZdjf5EAN9ZGb9srWF9DUGbeER79nWT5doDtK23/3256.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/47.mp4' }
    end

    factory :eclipse_ultra_legendary do
      token_address { '0x17aad3fcf1703ef7908777084ec24e55bc58ae33' }
      token_id { 619 }
      name { 'Electric Thunder' }
      animation_url { 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/619.mp4' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/619.mp4' }
    end

    factory :genesis_legendary do
      token_address { '0x5c3cc8d8f5c2186d07d0bd9e5b463dca507b1708' }
      token_id { 4994 }
      name { 'Lucid Dreamer' }
      image_url { 'ipfs://QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/4994.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/4994.png' }
    end

    factory :eclipse_legendary do
      token_address { '0x17aad3fcf1703ef7908777084ec24e55bc58ae33' }
      token_id { 456 }
      name { 'Golden Impaler' }
      image_url { 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/456.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/456.png' }
    end

    factory :genesis_rare do
      token_address { '0x5c3cc8d8f5c2186d07d0bd9e5b463dca507b1708' }
      token_id { 3217 }
      name { 'Morde #3217' }
      image_url { 'ipfs://QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/3217.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmSCpGdCSo5iDXDdGcJRWA9kcB22MdBo1xwnoMpx1nj937/3217.png' }
    end

    factory :eclipse_rare do
      token_address { '0x17aad3fcf1703ef7908777084ec24e55bc58ae33' }
      token_id { 1592 }
      name { 'Hiroh #1592' }
      image_url { 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/1592.png' }
      url { 'https://clementinesnightmare.mypinata.cloud/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/1592.png' }
    end

    factory :akcb do
      token_address { '0x77372a4cc66063575b05b44481f059be356964a4' }
      token_id { 3256 }
      name { 'BEAST #3256' }
      image_url { 'ipfs://QmSeMiDdZdjf5EAN9ZGb9srWF9DUGbeER79nWT5doDtK23/3256.png' }
      url { 'ipfs://QmSeMiDdZdjf5EAN9ZGb9srWF9DUGbeER79nWT5doDtK23/3256.png' }
    end
  end
end
