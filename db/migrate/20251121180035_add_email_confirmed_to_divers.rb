class AddEmailConfirmedToDivers < ActiveRecord::Migration[8.0]
  def change
    add_column :divers, :email_confirmed, :boolean, null: false, default: false
  end
end
