#require "spec_helper"
#require "cancan/matchers"
#def login_admin
  #before(:each) do
    ##@request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in FactoryGirl.create(:diver, id: 157, role: Diver::DIVER) # Using factory girl as an example
  #end
#end

#describe SamplesController do
  #login_admin


  
  #describe "GET index"do
    #let!(:diver) {subject.current_diver}
    #let!(:sample_animal) {FactoryGirl.create(:sample_animal, :sample => nil)}
    #let!(:sample) do 
      #s = FactoryGirl.build(:sample)
      #s.sample_animals << sample_animal
      #s.save
      #s
    #end
    #let!(:diver_sample) {FactoryGirl.create(:diver_sample, :sample => sample, :diver => diver)}
    #it "should have a current_diver" do
      #binding.pry
      ## note the fact that I removed the "validate_session" parameter if this was a scaffold-generated controller
      #subject.current_diver.should_not be_nil
    #end
    ##it "should have proofing samples" do
      ##assigns(:proofing_samples).should_not be_empty
    ##end
  #end



#end
