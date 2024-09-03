class AddColumnToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :date_of_birth, :date
    add_reference :employees, :user, foreign_key: true, null: false
  end
end
