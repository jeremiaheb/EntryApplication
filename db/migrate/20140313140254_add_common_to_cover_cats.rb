class AddCommonToCoverCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cover_cats, :common, :string
  end
end
