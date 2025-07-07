class CreatePresenceBelts < ActiveRecord::Migration[5.1]
  def change
    create_table :presence_belts do |t|
      t.integer :benthic_cover_id
      t.integer :a_palmata
      t.integer :a_cervicornis
      t.integer :d_cylindrus
      t.integer :m_ferox
      t.integer :m_annularis
      t.integer :m_franksi
      t.integer :m_faveolata
      t.integer :d_stokesii
      t.integer :a_lamarcki
    end
  end
end
