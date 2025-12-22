class AddJuvenileToDemographicCorals < ActiveRecord::Migration[8.0]
  def change
    add_column :demographic_corals, :juvenile, :boolean, default: false, null: false
  end
end
