class ChangeNullForCoralsAndCoverCats < ActiveRecord::Migration[5.2]
  def change
    change_column_null :corals, :short_code, false
    change_column_null :cover_cats, :proofing_code, false
  end
end
