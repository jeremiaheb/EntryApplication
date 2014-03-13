require "spec_helper"

describe CoverCat do

  describe "validations" do
    let(:cover_cat) { FactoryGirl.create(:cover_cat, :code => "RHO CRUS", :name => "Rhodophyta cru. spp", :common => "CCA Crustose Coralline Algae") }
    it "has valid factory" do
      cover_cat.should be_valid
    end

    it "is invalid without name" do
      FactoryGirl.build(:cover_cat, :name => nil).should_not be_valid
    end

    it "should have correct cover_code_name" do
      expect(cover_cat.cover_code_name).to eq("RHO CRUS __ CCA Crustose Coralline Algae")
    end
  end
  

    


end
