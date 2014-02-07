require "spec_helper"

describe CoverCat do

  describe "validations" do
    let(:cover_cat) { FactoryGirl.create(:cover_cat, :code => "ACRPALM", :name => "Acropora palmata") }
    it "has valid factory" do
      cover_cat.should be_valid
    end

    it "is invalid without name" do
      FactoryGirl.build(:cover_cat, :name => nil).should_not be_valid
    end

    it "should have correct cover_code_name" do
      expect(cover_cat.cover_code_name).to eq("ACRPALM __ Acropora palmata")
    end
  end
  

    


end
