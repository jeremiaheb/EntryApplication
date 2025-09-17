class AddDiverIdIndexes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :benthic_covers, :diver_id, false
    add_index :benthic_covers, :diver_id

    change_column_null :coral_demographics, :diver_id, false
    add_index :coral_demographics, :diver_id

    change_column_null :diver_samples, :diver_id, false
    change_column_null :diver_samples, :sample_id, false
    add_index :diver_samples, [:diver_id, :sample_id]
    add_index :diver_samples, :sample_id
  end
end
