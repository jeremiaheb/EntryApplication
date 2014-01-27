class AddCodeToCoverCats < ActiveRecord::Migration
  def change
    add_column :cover_cats, :code, :string

  end
end
