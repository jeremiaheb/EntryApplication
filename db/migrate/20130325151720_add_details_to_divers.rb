class AddDetailsToDivers < ActiveRecord::Migration[5.1]
  def change
    add_column :divers, :username, :string

    add_column :divers, :firstname, :string

    add_column :divers, :lastname, :string
  end
end
