class Draft < ApplicationRecord
  belongs_to :diver
  validates :diver_id, presence: true

  validates :model_klass, presence: true, inclusion: [::Sample.to_s, ::BenthicCover.to_s, ::CoralDemographic.to_s, ::BoatLog.to_s]

  validates :sequence, presence: true, uniqueness: { scope: [:diver_id, :model_klass, :model_id] }

  validates :focused_dom_id, format: /\A[a-zA-Z0-9_-]{0,100}\z/

  def self.for_diver_and_model(diver_id:, model_klass:, model_id:)
    where(diver_id: diver_id, model_klass: model_klass.to_s, model_id: model_id)
  end

  # Find the latest Draft for a given diver ID, model klass and model ID. If none
  # exist, nil is returned.
  #
  # For example usage, see test/models/draft_type.rb
  def self.latest_for(diver_id:, model_klass:, model_id:)
    for_diver_and_model(diver_id: diver_id, model_klass: model_klass, model_id: model_id).order(sequence: :desc).first
  end

  # Destroy all drafts for a given diver ID, model klass and model ID, if any
  # exist.
  def self.destroy_for(diver_id:, model_klass:, model_id:)
    # delete_all is used instead of destroy_all for performance. Otherwise, each
    # model has to be constructed because it may have callbacks to run. A
    # consequence of using delete_all here is that destroy callbacks can never
    # be added for Draft.
    for_diver_and_model(diver_id: diver_id, model_klass: model_klass, model_id: model_id).delete_all
  end

  # Destroy all drafts created before a certain time, which by now are no longer
  # useful and just clogging up the database.
  def self.destroy_stale(before: 15.days.ago)
    where("created_at < ?", before).destroy_all
  end

  # Reconstruct the model for this draft using the saved attributes. Returns the
  # model with updated attributes.
  def assign_attributes_to(model)
    model_attributes.each_pair do |k, v|
      model.public_send(:"#{k}=", v)
    rescue NoMethodError
      # This key is apparently invalid. We'll apply the other attributes and
      # ignore this one.
    rescue StandardError
      # The value is apparently invalid. We'll apply the other attributes and
      # ignore this one.
    end

    model
  end
end
