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

  describe 'associations' do
    let!(:boatlog_manager) { FactoryGirl.create(:boatlog_manager) }
    let!(:other_boatlog_manager) { FactoryGirl.create(:boatlog_manager) }
    let!(:benthic_covers) do 
      [
        FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager),
        FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager),
        FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager)
      ]
    end
    let!(:other_benthic_covers) do
      [
        FactoryGirl.create(:benthic_cover, :boatlog_manager => other_boatlog_manager),
        FactoryGirl.create(:benthic_cover, :boatlog_manager => other_boatlog_manager),
        FactoryGirl.create(:benthic_cover, :boatlog_manager => other_boatlog_manager)
      ]
    end

    it "should only show my benthic covers" do
      expect(BenthicCover.count).to eq(6)
      expect(boatlog_manager.benthic_covers.size).to eq(3)
      expect(boatlog_manager.benthic_covers.first).to eq(benthic_covers.first)
    end
  end

  describe "agency_name" do
    let!(:boatlog_manager) { FactoryGirl.create(:boatlog_manager, :agency => "FWC", :lastname => "Johnson") }

    it "should have correct agency_name" do
      expect(boatlog_manager.agency_name).to eq("FWC/Johnson")
    end

  end

  #describe '#spp_code_common' do
    #let(:animal) { FactoryGirl.create(:animal) }

    #it 'joins #species_code and #common_name' do
      #expect(animal.spp_code_common).to eq('MY_FISH __ My Fish')
    #end
  #end
end
