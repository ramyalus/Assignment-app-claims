class Reimbursement < ApplicationRecord
  has_one_attached :receipt
  belongs_to :employee, inverse_of: :reimbursements 
  belongs_to :company
end
