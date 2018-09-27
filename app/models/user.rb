class User < ActiveRecord::Base
	#Associations
	has_many :posts
  has_many :audit_logs

  #Definimos la relación auto-referencial
  # Es distinto de una red social donde la relación va en los dos sentidos
  has_many :hands_associations, class_name: 'Hand'
  has_many :hands, through: :hands_associations

	#Authorization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Validations
  validates :first_name, :last_name, :phone, :ssn, :company, presence: true  

  validates :phone, length: { is: 10 }

  validates :ssn, length: { is: 4 }
  validates_numericality_of :ssn

  PHONE_REGEX = /\A[0-9]*\Z/

  validates_format_of :phone, with: PHONE_REGEX

  #custom methods
  def full_name
  	last_name.upcase + ", " + first_name.upcase
  end  

end
