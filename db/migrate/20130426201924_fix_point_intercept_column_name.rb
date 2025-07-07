class FixPointInterceptColumnName < ActiveRecord::Migration[5.1]
  def up

    rename_column :point_intercepts, :bethic_cover_id, :benthic_cover_id
  end

  def down
  end
end
