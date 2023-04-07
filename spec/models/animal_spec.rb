require 'spec_helper'

describe Animal do
  describe 'validations' do
    let(:animal) { FactoryGirl.create(:animal) }
      it "should have valid factory" do
        expect(animal).to be_valid
      end
        
      [ :species_code, :scientific_name, :common_name, :max_size, :min_size, :max_number].each do |attribute|
        it "is invalid without #{attribute}" do
          expect(FactoryGirl.build(:animal, attribute => nil)).not_to be_valid
        end
      end
  end

  describe '#spp_code_common' do
    let(:animal) { FactoryGirl.create(:animal, :species_code => 'MY_FISH', :common_name => 'A Fish') }

    it 'joins #species_code and #common_name' do
      expect(animal.spp_code_common).to eq('MY_FISH __ A Fish')
    end
  end
end
