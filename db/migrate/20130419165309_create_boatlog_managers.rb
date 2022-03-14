class CreateBoatlogManagers < ActiveRecord::Migration
  def change
    create_table :boatlog_managers do |t|
      t.string :agency
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
