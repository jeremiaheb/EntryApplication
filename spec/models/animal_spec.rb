require 'spec_helper'

describe Animal do
  describe 'validations' do
    let(:animal) { FactoryGirl.create(:animal) }
      it "should have valid factory" do
        animal.should be_valid
      end
      
      it "should require a species code" do 
        FactoryGirl.build(:animal, :species_code => "").should_not be_valid
      end
      it "should require a scientific name" do 
        FactoryGirl.build(:animal, :scientific_name => "").should_not be_valid
      end
      it "should require a common name" do 
        FactoryGirl.build(:animal, :common_name => "").should_not be_valid
      end
      it "should require a max size" do 
        FactoryGirl.build(:animal, :max_size => "").should_not be_valid
      end
      it "should require a minimum size" do 
        FactoryGirl.build(:animal, :min_size => "").should_not be_valid
      end
      it "should require a maximum number" do 
        FactoryGirl.build(:animal, :max_number => "").should_not be_valid
      end
  end

  describe '#spp_code_common' do
    let(:animal) { FactoryGirl.create(:animal) }

    it 'joins #species_code and #common_name' do
      expect(animal.spp_code_common).to eq('MY_FISH __ My Fish')
    end
  end
end
