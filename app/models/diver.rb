class Diver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :firstname, :lastname
  
  has_many :diver_samples
  has_many :samples, :through => :diver_samples, :dependent => :destroy

  validates :diver_number, :presence => true
  validates :diver_name, :presence => true


  scope :active_divers,      lambda { where(:active => true) }
end
