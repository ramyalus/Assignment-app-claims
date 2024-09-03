class Employee < ApplicationRecord
	belongs_to :company
	belongs_to :user
	has_many :reimbursements, inverse_of: :employee
	validates :name, :date_of_birth, :qualification, :designation, :email, presence: true
	validates :email, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
	before_validation :set_user_id 
	def set_user_id
		self.user_id = self.company.user_id
	end
end
