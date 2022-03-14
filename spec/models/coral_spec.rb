require 'spec_helper'


describe Coral do
  describe 'validations' do
    let(:coral) { FactoryGirl.create(:coral) }
      it "should have valid factory" do
        coral.should be_valid
      end
        
      [ :code, :scientific_name ].each do |attribute|
        it "is invalid without #{attribute}" do
          FactoryGirl.build(:coral, attribute => nil).should_not be_valid
        end
      end
  end

end
