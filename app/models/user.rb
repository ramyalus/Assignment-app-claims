class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :companies
  has_many :employees
  validates :email, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
  def self.from_omniauth(auth)
  	@user = User.find_or_create_by(email: auth["email"]) do |user|
			user.name = auth["name"]
			user.first_name = auth["first_name"]
			user.last_name = auth["last_name"]
			user.image_url = auth["image"]
			user.password = auth["email"].split("@")[0]
		end
  end
end
