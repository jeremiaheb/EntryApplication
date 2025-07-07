class AddActiveToDivers < ActiveRecord::Migration[5.1]
  def change
    add_column :divers, :active, :boolean

  end
end
