class Diver < ActiveRecord::Base

  ROLES = %w[admin manager diver]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :firstname, :lastname, :role, :diver_name, :diver_number, :active, :boatlog_manager_id
  belongs_to  :boatlog_manager
  has_many    :diver_samples
  has_many    :samples, :through => :diver_samples, :dependent => :destroy

  has_many    :benthic_covers
  has_many    :coral_demographics
  
  validates   :diver_number, :presence => true
  validates   :diver_name, :presence => true


  scope       :active_divers,      lambda { where(:active => true) }

  def whole_name
    [ self.firstname, self.lastname ].join("  ")
  end

end
