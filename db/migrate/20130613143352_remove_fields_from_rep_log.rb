class RemoveFieldsFromRepLog < ActiveRecord::Migration
  def up
    remove_column :rep_logs, :created_at
        remove_column :rep_logs, :updated_at
      end

  def down
    add_column :rep_logs, :updated_at, :datetime
    add_column :rep_logs, :created_at, :datetime
  end
end
