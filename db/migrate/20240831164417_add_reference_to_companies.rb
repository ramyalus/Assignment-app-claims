class AddReferenceToCompanies < ActiveRecord::Migration[7.2]
  def change
    add_reference :companies, :user, foreign_key: true, null: false
    add_column :companies, :description, :text
  end
end
