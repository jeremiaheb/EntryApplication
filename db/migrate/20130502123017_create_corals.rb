class CreateCorals < ActiveRecord::Migration
  def change
    create_table :corals do |t|
      t.string :code
      t.string :scientific_name

      t.timestamps
    end
  end
end
