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
  validates   :username, uniqueness: { case_sensitive: false, allow_blank: true }
  validates   :email, uniqueness: { case_sensitive: false }
  validates   :boatlog_manager_id, uniqueness: true, allow_nil: true

  scope       :active_divers,      lambda { where(active: true) }

  def self.find_for_database_authentication(conditions)
    # See https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
    if (login = conditions[:login])
      where("(email IS NOT NULL AND LENGTH(email) > 0 AND LOWER(email) = LOWER(:login)) OR (username IS NOT NULL AND LENGTH(username) > 0 AND LOWER(username) = LOWER(:login))", login: login).first
    else
      super
    end
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

  # Login always returns email address. However, during a transition period, a
  # diver may use email OR username as their login for authentication.
  #
  # See Diver.find_for_database_authentication for the implementation of login
  # via email or username.
  def login
    email
  end

  def login=(login)
    # login cannot be set directly
  end
end
