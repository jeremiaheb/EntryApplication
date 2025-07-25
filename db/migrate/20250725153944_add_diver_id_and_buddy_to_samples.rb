class AddDiverIdAndBuddyToSamples < ActiveRecord::Migration[7.1]
  def change
    change_table :samples do |t|
      t.integer :diver_id
      t.integer :buddy_id

      t.index [:diver_id]
      t.index [:buddy_id]
    end
  end
end
