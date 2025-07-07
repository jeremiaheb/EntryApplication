class AddDiseaseToDemographicCorals < ActiveRecord::Migration[5.1]
  def change
    add_column :demographic_corals, :disease, :string
  end
end
