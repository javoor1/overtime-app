class User < ActiveRecord::Base
	#Associations
	has_many :posts


	#Authorization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Validations
  validates :first_name, :last_name, :phone, presence: true       

  #custom methods
  def full_name
  	last_name.upcase + ", " + first_name.upcase
  end


end
