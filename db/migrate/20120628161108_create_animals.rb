class CreateAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :animals do |t|
      t.string  :species_code
      t.string  :scientific_name
      t.string  :common_name
      t.integer :max_size
      t.integer :min_size
      t.integer :max_number

      t.timestamps
    end
  end
end
