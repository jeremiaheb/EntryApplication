class AddProofingCodeAndRankToCoverCats < ActiveRecord::Migration[5.2]
  def change
    change_column_null :cover_cats, :name, null: false
    change_column_null :cover_cats, :code, null: false
    add_column :cover_cats, :proofing_code, :string
    add_column :cover_cats, :rank, :integer, default: 2**31-1, null: false
  end
end
