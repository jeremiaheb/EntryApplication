class AddRoleToDivers < ActiveRecord::Migration
  def change
    add_column :divers, :role, :string

  end
end
