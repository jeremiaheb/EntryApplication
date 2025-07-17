class AddUniqueBoatlogManagerIndex < ActiveRecord::Migration[5.1]
  def up
    add_index :divers, :boatlog_manager_id, unique: true
  end

  def down
  end
end
