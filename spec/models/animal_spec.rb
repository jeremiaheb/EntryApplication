require 'spec_helper'

describe Animal do
  describe 'validations' do
    let(:animal) { FactoryGirl.create(:animal) }
      it "should have valid factory" do
        animal.should be_valid
      end
        
      [ :species_code, :scientific_name, :common_name, :max_size, :min_size, :max_number].each do |attribute|
        it "is invalid without #{attribute}" do
          FactoryGirl.build(:animal, attribute => nil).should_not be_valid
        end
      end
  end

  describe '#spp_code_common' do
    let(:animal) { FactoryGirl.create(:animal) }

    it 'joins #species_code and #common_name' do
      expect(animal.spp_code_common).to eq('MY_FISH __ My Fish')
    end
  end
end
