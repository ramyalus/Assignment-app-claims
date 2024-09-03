class Company < ApplicationRecord
	validates :company_name, uniqueness: true, presence: true
	belongs_to :user
	has_many :employees
	has_many :reimbursements
end
