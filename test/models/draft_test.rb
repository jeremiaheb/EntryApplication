require "test_helper"

class DraftTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    draft = FactoryBot.create(:draft)
    assert draft.valid?
  end

  test "records drafts for divers by model and model ID" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    sample1 = FactoryBot.build(:sample)
    draft1 = Draft.new(diver_id: diver1.id, model_klass: Sample, model_id: nil, model_attributes: sample1.attributes, sequence: 1000)
    draft1.save!

    saved_coral_demographic1 = FactoryBot.create(:coral_demographic)
    saved_draft1 = Draft.new(diver_id: diver1.id, model_klass: CoralDemographic, model_id: saved_coral_demographic1.id, model_attributes: saved_coral_demographic1.attributes, sequence: 1000)
    saved_draft1.save!

    sample2 = FactoryBot.build(:sample)
    draft2 = Draft.new(diver_id: diver1.id, model_klass: Sample, model_id: nil, model_attributes: sample2.attributes, sequence: 2000)
    draft2.save!

    latest = Draft.latest_for(diver_id: diver1.id, model_klass: Sample, model_id: nil)
    assert_equal draft2, latest

    latest = Draft.latest_for(diver_id: diver1.id, model_klass: CoralDemographic, model_id: saved_coral_demographic1.id)
    assert_equal saved_draft1, latest

    # No Coral Demographics have been saved, so should be nil
    assert_nil Draft.latest_for(diver_id: diver1.id, model_klass: CoralDemographic, model_id: nil)
    # Sample draft was for diver1, not diver2
    assert_nil Draft.latest_for(diver_id: diver2.id, model_klass: Sample, model_id: nil)
  end

  test "rejects models other than allowed list" do
    diver1 = FactoryBot.create(:diver)

    coral1 = FactoryBot.build(:coral)
    draft1 = Draft.new(diver_id: diver1.id, model_klass: Coral, model_id: nil, model_attributes: coral1.attributes, sequence: 1000)

    assert_not draft1.valid?
    assert_not_nil draft1.errors[:model_klass]
  end

  test "discards all drafts for a given diver ID and model type" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    sample1 = FactoryBot.build(:sample)
    draft1 = Draft.new(diver_id: diver1.id, model_klass: Sample, model_id: nil, model_attributes: sample1.attributes, sequence: 1000)
    assert draft1.save

    coral_demographic1 = FactoryBot.build(:coral_demographic)
    draft2 = Draft.new(diver_id: diver1.id, model_klass: CoralDemographic, model_id: nil, model_attributes: coral_demographic1.attributes, sequence: 1000)
    assert draft2.save

    # Draft from diver2 instead of diver1
    sample2 = FactoryBot.build(:sample)
    draft3 = Draft.new(diver_id: diver2.id, model_klass: Sample, model_id: nil, model_attributes: sample2.attributes, sequence: 1000)
    assert draft3.save

    assert 3, Draft.count

    # Target each draft by diver ID and model type
    Draft.destroy_for(diver_id: diver1.id, model_klass: Sample, model_id: nil)
    assert 2, Draft.count

    Draft.destroy_for(diver_id: diver1.id, model_klass: CoralDemographic, model_id: nil)
    assert 1, Draft.count

    # Does not target any saved draft
    Draft.destroy_for(diver_id: diver2.id, model_klass: CoralDemographic, model_id: nil)
    assert 1, Draft.count

    Draft.destroy_for(diver_id: diver2.id, model_klass: Sample, model_id: nil)
    assert 0, Draft.count
  end

  test "#assign_attributes_to" do
    diver = FactoryBot.create(:diver)

    sample = FactoryBot.build(:sample, field_id: "12345A")
    draft = Draft.create!(diver_id: diver.id, model_klass: Sample, model_id: nil, model_attributes: sample.attributes, sequence: 1000)

    restored_sample = Sample.new
    assert_nil restored_sample.field_id

    restored_sample = draft.assign_attributes_to(restored_sample)
    assert_equal "12345A", restored_sample.field_id
  end

  test "#assign_attributes_to does not raise if some model_attributes are invalid" do
    # This case happens when, e.g., a field is removed from a model but there
    # are outstanding drafts that still have that field. We want to ignore the
    # attributes, but not raise.
    diver = FactoryBot.create(:diver)

    sample = FactoryBot.build(:sample, field_id: "12345A")
    draft = Draft.create!(diver_id: diver.id, model_klass: Sample, model_id: nil, model_attributes: sample.attributes.merge("bogus" => "bogus field"), sequence: 1000)

    restored_sample = draft.assign_attributes_to(Sample.new)
    assert_equal "12345A", restored_sample.field_id

    # But if attributes are assigned in another way later, it will raise as usual
    assert_raises ActiveModel::UnknownAttributeError do
      restored_sample.assign_attributes("bogus" => "bogus field")
    end
  end
end
