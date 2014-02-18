require "spec_helper"

describe Sample do 


  describe "diver common fields" do
    let!(:diver) {FactoryGirl.create(:diver, :id => 157, :diver_number => "0157")}
    let!(:sample_animal) {FactoryGirl.create(:sample_animal, :sample => nil)}
    let!(:sample) do 
      s = FactoryGirl.build(:sample)
      s.sample_animals << sample_animal
      s.save
      s
    end
    let!(:diver_sample) {FactoryGirl.create(:diver_sample, :sample => sample, :diver => diver)}
    it "should return primary diver number" do
      binding.pry
      expect(sample.diver.diver_number).to eq("0157")  
    end
    it "should have correct id" do 
      expect(sample.myId).to eq(157)
    end
    it "should upcase field id"do 
      expect(sample.field_id).to eq("10011A")
    end
    it "should return correct msn" do
      expect(sample.msn).to eq("A2014020209050157")
    end
  end

end
