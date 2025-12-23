class Diver < ApplicationRecord
  DIVER   = "diver"
  ADMIN   = "admin"
  ROLES   = [DIVER, ADMIN]

  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:icam, :developer]

  has_many    :samples
  has_many    :samples_missions, through: :samples

  has_many    :benthic_covers
  has_many    :coral_demographics

  has_many    :rep_logs

  has_many :mission_managers
  has_many :missions_managed, through: :mission_managers, source: :mission

  validates   :diver_number, presence: true, uniqueness: true
  validates   :diver_name, presence: true, uniqueness: { case_sensitive: false }
  validates   :agency, presence: true, except_on: [:admin, :import]
  validates   :username, uniqueness: { case_sensitive: false }
  validates   :email, uniqueness: { case_sensitive: false }
  validates   :role, inclusion: { in: ROLES }
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

  def active_for_authentication?
    # Do not allow deprecated "boatlog manager" users to login anymore
    super && ROLES.include?(self.role)
  end

  def inactive_message
    if !ROLES.include?(self.role)
      return "Your diver role is not valid."
    end

    super
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
    if username.present? && valid_password?(username)
      errors.add(:password, "must not be the same as username")
    end
  end

  def password_is_not_username
    if (username.present? && username.downcase == password.downcase) || diver_name.downcase == password.downcase || email.downcase == password.downcase
      errors.add(:password, "must not be the same as username, diver name or email")
    end
  end
end
