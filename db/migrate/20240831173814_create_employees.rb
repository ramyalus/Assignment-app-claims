class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :qualification
      t.string :age
      t.string :designation
      t.string :email
      t.references :company, foreign_key: true, null:false
      t.timestamps
    end
  end
end
