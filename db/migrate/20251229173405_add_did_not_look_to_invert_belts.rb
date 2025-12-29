class AddDidNotLookToInvertBelts < ActiveRecord::Migration[8.0]
  def change
    add_column :invert_belts, :lobster_num_did_not_look, :boolean, null: false, default: false
    add_column :invert_belts, :conch_num_did_not_look, :boolean, null: false, default: false
    add_column :invert_belts, :diadema_num_did_not_look, :boolean, null: false, default: false
  end
end
