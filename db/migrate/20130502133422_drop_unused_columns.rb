class DropUnusedColumns < ActiveRecord::Migration[5.1]
  def up
    remove_column   :demographic_corals,  :created_at
    remove_column   :demographic_corals,  :updated_at
    remove_column   :diver_samples,       :created_at
    remove_column   :diver_samples,       :updated_at
  end

  def down
  end
end
