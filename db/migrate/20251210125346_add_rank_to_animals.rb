class AddRankToAnimals < ActiveRecord::Migration[8.0]
  def change
    add_column :animals, :rank, :integer, default: 2**31-1, null: false
  end
end
