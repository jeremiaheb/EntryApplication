require "spec_helper"

describe PointIntercept do

  describe "validations" do
    let(:point_intercept) { FactoryGirl.create(:point_intercept) }
    
    it "has valid factory" do
      expect(point_intercept).to be_valid
    end

    it "should have correct cover_total" do
      expect(point_intercept.cover_total).to eq(75)
    end

  end
  

    


end

