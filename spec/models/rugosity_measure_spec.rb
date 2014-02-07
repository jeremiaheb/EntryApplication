require "spec_helper"

describe RugosityMeasure do

  describe "validations" do
    let(:rugosity_measure) { FactoryGirl.create(:rugosity_measure) }
    
    it "has valid factory" do
      rugosity_measure.should be_valid
    end

    it "should have correct sum of categories" do
      expect(rugosity_measure.category_sum).to eq(24)
    end

  end
  

    


end
