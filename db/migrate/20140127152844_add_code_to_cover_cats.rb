class AddCodeToCoverCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cover_cats, :code, :string

  end
end
