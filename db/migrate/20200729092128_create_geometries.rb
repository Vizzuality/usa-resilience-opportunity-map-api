class CreateGeometries < ActiveRecord::Migration[6.0]
  def change
    create_table :geometries do |t|
      t.geometry :geom
      t.string :name, null: false
      t.text :description
      t.string :gid, null: false
      t.integer :location_type, null: false
      t.integer :parent_id

      t.timestamps

      t.index :name
      t.index :gid
      t.index :location_type
      t.index :parent_id
    end
  end
end
