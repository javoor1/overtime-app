class User < ActiveRecord::Base
	#Associations
	has_many :posts


	#Authorization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Validations
  validates :first_name, :last_name, presence: true       
end
