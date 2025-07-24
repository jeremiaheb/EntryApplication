class CreateAgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :agencies do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
