class RemoveDefaultForDiverEmail < ActiveRecord::Migration[7.1]
  def change
    change_column :divers, :email, :string, default: nil, null: false
  end
end
