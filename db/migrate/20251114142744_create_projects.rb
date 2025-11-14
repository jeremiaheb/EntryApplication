class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false

      t.timestamps null: false
      t.index :name, unique: true
    end
  end
end
