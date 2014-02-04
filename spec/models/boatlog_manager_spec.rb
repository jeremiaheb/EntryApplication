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

  describe 'divers_responsible_for' do
    let!(:boatlog_manager) { FactoryGirl.create(:boatlog_manager) }
    let!(:benthic_cover){FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager)}
    let!(:other_benthic_cover){FactoryGirl.create(:benthic_cover)}
    let!(:coral_demographic) { FactoryGirl.create(:coral_demographic, :boatlog_manager => boatlog_manager) }
    let!(:other_coral_demographic) { FactoryGirl.create(:coral_demographic) }
    let!(:sample_animal) {FactoryGirl.create(:sample_animal, :sample => nil)}
    let!(:sample) do 
      s = FactoryGirl.build(:sample, :boatlog_manager => boatlog_manager)
      s.sample_animals << sample_animal
      s.save
      s
    end
    let!(:diver_sample) {FactoryGirl.create(:diver_sample, :sample => sample)}
    let!(:other_diver_sample) {FactoryGirl.create(:diver_sample, :sample => nil)}

    it "should have correct divers" do
      expect(BenthicCover.count).to eq(2)
      expect(CoralDemographic.count).to eq(2)
      expect(DiverSample.count).to eq(2)
      expect(boatlog_manager.divers_responsible_for.size).to eq(3)
      expect(boatlog_manager.divers_responsible_for).to match_array( [coral_demographic.diver, benthic_cover.diver, diver_sample.diver] )
    end

    describe "uniqueness" do
      let!(:benthic2) { FactoryGirl.create(:benthic_cover, :diver => benthic_cover.diver, :boatlog_manager => boatlog_manager) }
      it "should return a unique list" do
        expect(BenthicCover.count).to eq(3)
        expect(BenthicCover.where(:diver_id => benthic2.diver_id).size).to eq(2)
        expect(boatlog_manager.divers_responsible_for).to match_array( [coral_demographic.diver, benthic_cover.diver, diver_sample.diver] )
      end
    end
  end

  describe "#benthic_covers_count_for_diver" do
    let!(:boatlog_manager) {FactoryGirl.create(:boatlog_manager)}
    let!(:diver) {FactoryGirl.create(:diver)}
    let!(:benthic_cover) do
     [ FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager, :diver => diver),
       FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager, :diver => diver),
      FactoryGirl.create(:benthic_cover, :boatlog_manager => boatlog_manager)]
    end
    let!(:benthic_cover_2) do
     [ FactoryGirl.create(:benthic_cover, :diver => diver),
       FactoryGirl.create(:benthic_cover, :diver => diver),
      FactoryGirl.create(:benthic_cover) ]
    end
    it "should return correct count of covers" do
      expect(boatlog_manager.benthic_covers_count_for_diver(diver)).to eq(2)
    end
  end

  describe "#coral_demographics_count_for_diver" do
    let!(:boatlog_manager) {FactoryGirl.create(:boatlog_manager)}
    let!(:diver) {FactoryGirl.create(:diver)}
    let!(:coral_demographic) do
     [ FactoryGirl.create(:coral_demographic, :boatlog_manager => boatlog_manager, :diver => diver),
       FactoryGirl.create(:coral_demographic, :boatlog_manager => boatlog_manager, :diver => diver),
       FactoryGirl.create(:coral_demographic, :boatlog_manager => boatlog_manager, :diver => diver),
       FactoryGirl.create(:coral_demographic, :boatlog_manager => boatlog_manager)]
    end
    let!(:coral_demographic_2) do
     [ FactoryGirl.create(:coral_demographic, :diver => diver),
       FactoryGirl.create(:coral_demographic, :diver => diver),
      FactoryGirl.create(:coral_demographic) ]
    end
    it "should return correct count of covers" do
      expect(boatlog_manager.coral_demographics_count_for_diver(diver)).to eq(3)
    end
  end

  describe "#samples_count_for_diver" do
    let!(:boatlog_manager) {FactoryGirl.create(:boatlog_manager)}
    let!(:sample_animal) {FactoryGirl.create(:sample_animal, :sample => nil)}
    let!(:diver) {FactoryGirl.create(:diver)}
    let!(:samples) do
      3.times.map do 
        s = FactoryGirl.build(:sample, :boatlog_manager => boatlog_manager)
        s.sample_animals << sample_animal
        s.save
        s
      end
    end
    let!(:diver_samples) do
     [ FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => true, :sample => samples[0]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => false, :sample => samples[0]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => true, :sample => samples[1]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => false, :sample => samples[1]),
       FactoryGirl.create(:diver_sample, :primary_diver => true, :sample => samples[2])]
    end

    it "should return correct count of primary diver samples" do
      expect(boatlog_manager.samples_count_for_diver(diver)).to eq(2)
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
