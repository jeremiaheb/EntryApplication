class CreateDivers < ActiveRecord::Migration[5.1]
  def change
    create_table :divers do |t|
      t.string    :diver_number
      t.string    :diver_name

      t.timestamps
    end
  end
end
