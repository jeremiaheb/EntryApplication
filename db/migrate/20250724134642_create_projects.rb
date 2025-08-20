class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
