class Diver < ApplicationRecord
  ADMIN   = "admin"
  MANAGER = "manager"
  DIVER   = "diver"
  ROLES   = [ADMIN, MANAGER, DIVER]

  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:icam, :developer]

  belongs_to  :boatlog_manager

  has_many    :samples
  has_many    :benthic_covers
  has_many    :coral_demographics

  has_many    :rep_logs

  validates   :diver_number, presence: true
  validates   :diver_name, presence: true
  validates   :boatlog_manager_id, uniqueness: true, allow_nil: true

  scope       :active_divers,      lambda { where(active: true) }

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
