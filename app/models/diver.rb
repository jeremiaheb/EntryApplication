class Diver < ActiveRecord::Base
  ADMIN   = 'admin'
  MANAGER = 'manager'
  DIVER   = 'diver'
  ROLES   = [ADMIN, MANAGER, DIVER]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable,
    omniauth_providers: [:login_dot_gov]

  belongs_to  :boatlog_manager
  has_many    :diver_samples
  has_many    :samples, :through => :diver_samples, :dependent => :destroy

  has_many    :benthic_covers
  has_many    :coral_demographics

  has_many    :rep_logs
  
  validates   :diver_number, :presence => true
  validates   :diver_name, :presence => true
  validates   :boatlog_manager_id, :uniqueness => true, :allow_nil => true

  scope       :active_divers,      lambda { where(:active => true) }
  
  def self.from_omniauth!(auth)
    find_by!(email: auth.info.email).tap do |d|
      d.provider = auth.provider
      d.uid = auth.uid
      d.password = Devise.friendly_token[0, 20] unless d.encrypted_password?
      d.save!
    end
  end

  def diver_proofing_samples
    diver_samples.primary.joins(:sample).order("sample_date")
  end

  def diver_proofing_benthic_cover
    benthic_covers.order("sample_date")
  end

  def diver_proofing_coral_demo
    coral_demographics.order("sample_date")
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
