require "spec_helper"

describe SampleType do 


  describe "msn" do
    let!(:diver) {FactoryGirl.create(:diver, :diver_number => "0157")}
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
  end

end
