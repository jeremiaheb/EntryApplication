class AddDiseaseToDemographicCorals < ActiveRecord::Migration
  def change
    add_column :demographic_corals, :disease, :string
  end
end
