require "spec_helper"

describe SampleType do 

  describe 'validations' do
    let(:sample_type) { FactoryGirl.create(:sample_type) }
      it "should have valid factory" do
        expect(sample_type).to be_valid
      end
        
      [ :sample_type_name, :sample_type_description ].each do |attribute|
        it "is invalid without #{attribute}" do
          expect(FactoryGirl.build(:sample_type, attribute => nil)).not_to be_valid
        end
      end
  end


end
