class CreateDrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :drafts do |t|
      t.references :diver, foreign_key: false, index: false
      t.string :model_klass, null: false
      t.integer :model_id, null: true # null: true for a new, unsaved record
      t.json :model_attributes, default: '{}', null: false
      t.string :focused_dom_id, null: true
      t.float :sequence, null: false

      t.timestamps null: false

      t.index [:diver_id, :model_klass, :model_id, :sequence], unique: true, order: { sequence: :desc }
    end
  end
end
