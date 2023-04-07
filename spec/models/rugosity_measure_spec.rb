require "spec_helper"

describe RugosityMeasure do

  describe "validations" do
    let(:rugosity_measure) { FactoryGirl.create(:rugosity_measure) }
    
    it "has valid factory" do
      expect(rugosity_measure).to be_valid
    end

    it "should have correct sum of categories" do
      expect(rugosity_measure.category_sum).to eq(170)
    end

  end
  

    


end
