class Diver < ActiveRecord::Base
  ADMIN   = 'admin'
  MANAGER = 'manager'
  DIVER   = 'diver'
  ROLES   = [ADMIN, MANAGER, DIVER]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_protected []
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :firstname, :lastname, :diver_name, :diver_number, :active, :boatlog_manager_id
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
