class CreateInvertBelts < ActiveRecord::Migration
  def change
    create_table :invert_belts do |t|
      t.integer :benthic_cover_id
      t.integer :lobster_num
      t.integer :conch_num
      t.integer :diadema_num
    end
  end
end
