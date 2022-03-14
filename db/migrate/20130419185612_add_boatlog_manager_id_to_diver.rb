class AddBoatlogManagerIdToDiver < ActiveRecord::Migration
  def change
    add_column :divers, :boatlog_manager_id, :integer

  end
end
