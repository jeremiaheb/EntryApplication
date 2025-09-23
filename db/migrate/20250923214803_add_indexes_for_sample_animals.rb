class AddIndexesForSampleAnimals < ActiveRecord::Migration[7.1]
  def change
    add_index :sample_animals, [:sample_id, :animal_id]
    add_index :sample_animals, :animal_id
  end
end
