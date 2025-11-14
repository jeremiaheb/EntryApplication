class CreateAgencies < ActiveRecord::Migration[7.2]
  def change
    create_table :agencies do |t|
      t.string :name, null: false

      t.timestamps null: false
      t.index :name, unique: true
    end
  end
end
