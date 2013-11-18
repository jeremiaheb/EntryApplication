require 'spec_helper'

describe BoatlogManager do
  
  describe 'validations' do
    let(:boatlog_manager) { FactoryGirl.create(:boatlog_manager) }
      it "should have valid factory" do
        boatlog_manager.should be_valid
      end
        
      [:agency, :firstname, :lastname].each do |attribute|
        it "is invalid without #{attribute}" do
          FactoryGirl.build(:boatlog_manager, attribute => nil).should_not be_valid
        end
      end
  end

  #describe '#spp_code_common' do
    #let(:animal) { FactoryGirl.create(:animal) }

    #it 'joins #species_code and #common_name' do
      #expect(animal.spp_code_common).to eq('MY_FISH __ My Fish')
    #end
  #end
end
