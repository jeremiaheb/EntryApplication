FactoryGirl.define do
  factory :draft do
    association(:diver)
    model_klass "Sample"
    model_attributes { FactoryGirl.attributes_for(:sample) }
    add_attribute(:sequence) { 1.5 }
    focused_dom_id "sample_field_id"
  end
end
