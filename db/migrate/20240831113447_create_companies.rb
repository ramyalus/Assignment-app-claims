class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :company_name 
      t.integer :employees_count
      t.float :sum_of_reimbursement_claims
      t.timestamps
    end
  end
end
