# frozen_string_literal: true

require 'rails_helper'

describe Nft do
  let(:genesis_nft) { build(:genesis) }
  let(:eclipse_nft) { build(:eclipse) }
  let(:non_clem_nft) { build(:akcb) }

  describe '#from_moralis' do
    it 'builds an Nft instance' do
      moralis_hash = JSON.parse(file_fixture('moralis/roux_atome_9916.json').read)
      nft = described_class.from_moralis(moralis_hash)
      expect(nft).to have_attributes(
        {
          token_address: Rails.configuration.clem_config['CONTRACT_ADDRESS_ECLIPSE'],
          token_id: 9916,
          name: 'Roux Atome #9916',
          image_url: 'ipfs://QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9916.png',
          url: 'https://clementinesnightmare.mypinata.cloud/ipfs/QmUgjPh7VV2KYkycLcfyiZ4bJNtLDcJ51e6WBhhkVtmUvS/9916.png'
        }
      )
    end
  end

  describe 'clem?' do
    it 'returns true if from Genesis collection' do
      expect(genesis_nft).to be_clem
    end

    it 'returns true if from Eclipse collection' do
      expect(eclipse_nft).to be_clem
    end

    it 'returns false if not from any Clementine\'s Nightmare collections' do
      expect(non_clem_nft).not_to be_clem
    end
  end

  describe 'genesis?' do
    it 'returns true if from Genesis collection' do
      expect(genesis_nft).to be_genesis
    end

    it 'returns false if from Eclipse collection' do
      expect(eclipse_nft).not_to be_genesis
    end

    it 'returns false if not from any Clementine\'s Nightmare collections' do
      expect(non_clem_nft).not_to be_genesis
    end
  end

  describe 'eclipse?' do
    it 'returns true if from Eclipse collection' do
      expect(eclipse_nft).to be_eclipse
    end

    it 'returns false if from Genesis collection' do
      expect(genesis_nft).not_to be_eclipse
    end

    it 'returns false if not from any Clementine\'s Nightmare collections' do
      expect(non_clem_nft).not_to be_eclipse
    end
  end

  describe 'ultra_legendary?' do
    shared_examples 'ultra legendary' do
      it do
        expect(nft).to be_ultra_legendary
      end
    end

    shared_examples 'not ultra legendary' do
      it do
        expect(nft).not_to be_ultra_legendary
      end
    end

    context 'when genesis ultra legendary' do
      let(:nft) { build(:genesis_ultra_legendary) }

      it_behaves_like 'ultra legendary'
    end

    context 'when eclipse ultra legendary' do
      let(:nft) { build(:eclipse_ultra_legendary) }

      it_behaves_like 'ultra legendary'
    end

    context 'when genesis non ultra legendary' do
      let(:nft) { genesis_nft }

      it_behaves_like 'not ultra legendary'
    end

    context 'when eclipse non ultra legendary' do
      let(:nft) { eclipse_nft }

      it_behaves_like 'not ultra legendary'
    end

    context 'when non clementine nft' do
      let(:nft) { non_clem_nft }

      it_behaves_like 'not ultra legendary'
    end
  end

  describe 'legendary?' do
    shared_examples 'legendary' do
      it do
        expect(nft).to be_legendary
      end
    end

    shared_examples 'not legendary' do
      it do
        expect(nft).not_to be_legendary
      end
    end

    context 'when genesis legendary' do
      let(:nft) { build(:genesis_legendary) }

      it_behaves_like 'legendary'
    end

    context 'when eclipse legendary' do
      let(:nft) { build(:eclipse_legendary) }

      it_behaves_like 'legendary'
    end

    context 'when genesis non legendary' do
      let(:nft) { genesis_nft }

      it_behaves_like 'not legendary'
    end

    context 'when eclipse non legendary' do
      let(:nft) { eclipse_nft }

      it_behaves_like 'not legendary'
    end

    context 'when non clementine nft' do
      let(:nft) { non_clem_nft }

      it_behaves_like 'not legendary'
    end
  end

  describe 'rare?' do
    shared_examples 'rare' do
      it do
        expect(nft).to be_rare
      end
    end

    shared_examples 'not rare' do
      it do
        expect(nft).not_to be_rare
      end
    end

    context 'when genesis rare' do
      let(:nft) { build(:genesis_rare) }

      it_behaves_like 'rare'
    end

    context 'when eclipse rare' do
      let(:nft) { build(:eclipse_rare) }

      it_behaves_like 'rare'
    end

    context 'when genesis non rare' do
      let(:nft) { genesis_nft }

      it_behaves_like 'not rare'
    end

    context 'when eclipse non rare' do
      let(:nft) { eclipse_nft }

      it_behaves_like 'not rare'
    end

    context 'when non clementine nft' do
      let(:nft) { non_clem_nft }

      it_behaves_like 'not rare'
    end
  end
end
