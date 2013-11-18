require "spec_helper"

describe SampleType do 

  describe 'validations' do
    let(:sample_type) { FactoryGirl.create(:sample_type) }
      it "should have valid factory" do
        sample_type.should be_valid
      end
        
      [ :sample_type_name, :sample_type_description ].each do |attribute|
        it "is invalid without #{attribute}" do
          FactoryGirl.build(:sample_type, attribute => nil).should_not be_valid
        end
      end
  end

end
