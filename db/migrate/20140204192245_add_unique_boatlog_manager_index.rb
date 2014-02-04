class AddUniqueBoatlogManagerIndex < ActiveRecord::Migration
  def up
    add_index :divers, :boatlog_manager_id, :unique => true
  end

  def down
  end
end
