class AddCommonToCoverCats < ActiveRecord::Migration
  def change
    add_column :cover_cats, :common, :string
  end
end
