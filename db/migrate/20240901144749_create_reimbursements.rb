class CreateReimbursements < ActiveRecord::Migration[7.2]
  def change
    create_table :reimbursements do |t|
      t.text :purpose
      t.float :amount, default: 0
      t.date :date_of_expenditure
      t.references :employee, foreign_key: true, null: false
      t.references :company, foreign_key: true, null: false
      t.timestamps
    end
  end
end
