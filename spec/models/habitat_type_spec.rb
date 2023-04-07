require "spec_helper"

describe HabitatType do 

  describe 'validations' do
    let(:habitat_type) { FactoryGirl.create(:habitat_type) }
      it "should have valid factory" do
        expect(habitat_type).to be_valid
      end
        
      [ :habitat_name, :habitat_description ].each do |attribute|
        it "is invalid without #{attribute}" do
          expect(FactoryGirl.build(:habitat_type, attribute => nil)).not_to be_valid
        end
      end
  end

end
