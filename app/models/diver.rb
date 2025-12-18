class Diver < ApplicationRecord
  ADMIN   = "admin"
  MANAGER = "manager"
  DIVER   = "diver"
  ROLES   = [ADMIN, DIVER]

  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:icam, :developer]

  has_many    :samples
  has_many    :samples_missions, through: :samples

  has_many    :benthic_covers
  has_many    :coral_demographics

  has_many    :rep_logs

  has_many :mission_managers
  has_many :missions_managed, through: :mission_managers, source: :mission

  validates   :diver_number, presence: true
  validates   :diver_name, presence: true
  validates   :agency, presence: true, except_on: [:admin, :import]
  validates   :username, uniqueness: { case_sensitive: false, allow_blank: true }
  validates   :email, uniqueness: { case_sensitive: false }
  validate    :current_password_is_not_username, except_on: [:admin, :import], unless: -> { password.present? }
  validate    :password_is_not_username, except_on: [:admin, :import], if: -> { password.present? }

  scope       :active_divers,      lambda { where(active: true) }

  # Temporarily allow a diver to be found by "login" which is EITHER email or
  # username.
  #
  # Eventually username will be deprecated.
  def self.find_first_by_auth_conditions(tainted_conditions, opts = {})
    conditions = devise_parameter_filter.filter(tainted_conditions).merge(opts)
    login = conditions.delete(:login)

    relation = where(conditions)
    if login
      relation = relation.where("(email IS NOT NULL AND LENGTH(email) > 0 AND LOWER(email) = LOWER(:login)) OR (username IS NOT NULL AND LENGTH(username) > 0 AND LOWER(username) = LOWER(:login))", login: login)
    end

    relation.first
  end

  def diver?
    self.role == Diver::DIVER
  end

  def admin?
    self.role == Diver::ADMIN
  end

  # Login always returns email address. However, during a transition period, a
  # diver may use email OR username as their login for authentication.
  #
  # See Diver.find_first_by_auth_conditions for the implementation of login
  # via email or username.
  def login
    email
  end

  def login=(login)
    # login cannot be set directly
  end

  def current_password_is_not_username
    if valid_password?(username)
      errors.add(:password, "must not be the same as username")
    end
  end

  def password_is_not_username
    if username.downcase == password.downcase || diver_name.downcase == password.downcase || email.downcase == password.downcase
      errors.add(:password, "must not be the same as username, diver name or email")
    end
  end
end
