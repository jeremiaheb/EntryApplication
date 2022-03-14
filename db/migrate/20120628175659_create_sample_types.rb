class CreateSampleTypes < ActiveRecord::Migration
  def change
    create_table :sample_types do |t|
      t.string    :sample_type_name
      t.string    :sample_type_description

      t.timestamps
    end
  end
end
