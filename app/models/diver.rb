class Diver < ActiveRecord::Base
  ADMIN   = "admin"
  MANAGER = "manager"
  DIVER   = "diver"
  ROLES   = [ADMIN, MANAGER, DIVER]

  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable

  belongs_to  :boatlog_manager

  has_many    :samples
  has_many    :benthic_covers
  has_many    :coral_demographics

  has_many    :rep_logs

  validates   :diver_number, presence: true
  validates   :diver_name, presence: true
  validates   :boatlog_manager_id, uniqueness: true, allow_nil: true

  scope       :active_divers,      lambda { where(active: true) }

  def diver_proofing_samples
    samples.order(:sample_date, :sample_begin_time)
  end

  def diver_proofing_benthic_cover
    benthic_covers.order(:sample_date, :sample_begin_time)
  end

  def diver_proofing_coral_demo
    coral_demographics.order(:sample_date, :sample_begin_time)
  end

  def whole_name
    "#{firstname} #{lastname}"
  end

  def diver?
    self.role == Diver::DIVER
  end

  def admin?
    self.role == Diver::ADMIN
  end

  def manager?
    self.role == Diver::MANAGER
  end
end
