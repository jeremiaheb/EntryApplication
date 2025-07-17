class AddRoleToDivers < ActiveRecord::Migration[5.1]
  def change
    add_column :divers, :role, :string
  end
end
