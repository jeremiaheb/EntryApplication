require 'spec_helper'
describe DemographicCoral do
  let (:demographic_coral) { FactoryGirl.build(:demographic_coral) }

  it 'has a valid factory' do
    expect(demographic_coral).to be_valid
  end
end
