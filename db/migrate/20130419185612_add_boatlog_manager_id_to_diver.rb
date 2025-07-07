class AddBoatlogManagerIdToDiver < ActiveRecord::Migration[5.1]
  def change
    add_column :divers, :boatlog_manager_id, :integer

  end
end
