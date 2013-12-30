require 'spec_helper'
describe CoralDemographic do
  let (:coral_demographic) { FactoryGirl.build(:coral_demographic) }

  it 'has a valid factory' do
    expect(coral_demographic).to be_valid
  end
end
