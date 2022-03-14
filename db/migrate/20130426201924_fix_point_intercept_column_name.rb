class FixPointInterceptColumnName < ActiveRecord::Migration
  def up

    rename_column :point_intercepts, :bethic_cover_id, :benthic_cover_id
  end

  def down
  end
end
