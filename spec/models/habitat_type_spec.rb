require "spec_helper"

describe HabitatType do 

  describe 'validations' do
    let(:habitat_type) { FactoryGirl.create(:habitat_type) }
      it "should have valid factory" do
        habitat_type.should be_valid
      end
        
      [ :habitat_name, :habitat_description ].each do |attribute|
        it "is invalid without #{attribute}" do
          FactoryGirl.build(:habitat_type, attribute => nil).should_not be_valid
        end
      end
  end

end
