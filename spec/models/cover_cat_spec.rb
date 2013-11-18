require "spec_helper"

describe CoverCat do

  describe "validations" do
    let(:cover_cat) { FactoryGirl.create(:cover_cat) }
    it "has valid factory" do
      cover_cat.should be_valid
    end

    it "is invalid without name" do
      FactoryGirl.build(:cover_cat, :name => nil).should_not be_valid
    end
  end
  

    


end
