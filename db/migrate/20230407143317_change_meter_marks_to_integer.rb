class ChangeMeterMarksToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :demographic_corals, :max_diameter,            :integer
    change_column :demographic_corals, :perpendicular_diameter,  :integer
    change_column :demographic_corals, :height,                  :integer
    change_column :demographic_corals, :old_mortality,           :integer
    change_column :demographic_corals, :recent_mortality,        :integer
  end
end
