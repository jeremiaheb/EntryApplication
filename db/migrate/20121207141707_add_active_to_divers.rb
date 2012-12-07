class AddActiveToDivers < ActiveRecord::Migration
  def change
    add_column :divers, :active, :boolean

  end
end
