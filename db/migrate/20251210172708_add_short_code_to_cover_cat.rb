class AddShortCodeToCoverCat < ActiveRecord::Migration[8.0]
  def change
    add_column :cover_cats, :short_code, :string
  end
end
