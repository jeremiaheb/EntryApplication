class InvertBelt < ApplicationRecord
  belongs_to :benthic_cover

  validates :lobster_num, presence: true, unless: :lobster_num_did_not_look?
  validates :lobster_num_did_not_look, inclusion: { in: [true, false] }

  validates :conch_num, presence: true, unless: :conch_num_did_not_look?
  validates :conch_num_did_not_look, inclusion: { in: [true, false] }

  validates :diadema_num, presence: true, unless: :diadema_num_did_not_look?
  validates :diadema_num_did_not_look, inclusion: { in: [true, false] }
end
