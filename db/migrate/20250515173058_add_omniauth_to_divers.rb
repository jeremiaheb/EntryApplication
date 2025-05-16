class AddOmniauthToDivers < ActiveRecord::Migration[7.1]
  def change
    add_column :divers, :provider, :string
    add_column :divers, :uid, :string
    add_index :divers, [:provider, :uid], unique: true
  end
end
