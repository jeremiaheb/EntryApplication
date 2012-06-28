class CreateHabitatTypes < ActiveRecord::Migration
  def change
    create_table :habitat_types do |t|
      t.string    :habitat_name
      t.string    :habitat_description

      t.timestamps
    end
  end
end
