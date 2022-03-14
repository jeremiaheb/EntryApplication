class CreateCoverCats < ActiveRecord::Migration
  def change
    create_table :cover_cats do |t|
      t.string  :name
      t.timestamps
    end
  end
end
