require 'spec_helper'


describe Coral do
  describe 'validations' do
    let(:coral) { FactoryGirl.create(:coral) }
      it "should have valid factory" do
        expect(coral).to be_valid
      end
        
      [ :code, :scientific_name ].each do |attribute|
        it "is invalid without #{attribute}" do
          expect(FactoryGirl.build(:coral, attribute => nil)).not_to be_valid
        end
      end
  end

end
