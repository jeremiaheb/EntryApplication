class AddShortCodeAndRankToCorals < ActiveRecord::Migration[5.2]
  def change
    change_column_null :corals, :code, null: false
    change_column_null :corals, :scientific_name, null: false
    add_column :corals, :common_name, :string
    add_column :corals, :short_code, :string
    add_column :corals, :rank, :integer, default: 2**31-1, null: false
  end
end
