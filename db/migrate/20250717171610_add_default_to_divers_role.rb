class AddDefaultToDiversRole < ActiveRecord::Migration[7.1]
  def change
    change_column_default :divers, :role, from: nil, to: "diver"
    change_column_null :divers, :role, false
  end
end
