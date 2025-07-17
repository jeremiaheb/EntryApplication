class CreateSampleAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :sample_animals do |t|
      t.integer :sample_id
      t.integer :animal_id
      t.integer :number_individuals
      t.integer :average_length
      t.integer :min_length
      t.integer :max_length
      t.integer :time_seen
    end
  end
end
