require 'spec_helper'

describe Animal do
  describe '#spp_code_common' do
    let(:animal) { Animal.new(species_code: 'species', common_name: 'common') }
    # let(:animal) { FactoryGirl.create(:animal) }

    it 'joins #species_code and #common_name' do
      expect(animal.spp_code_common).to eq('species __ common')
    end
  end
end
