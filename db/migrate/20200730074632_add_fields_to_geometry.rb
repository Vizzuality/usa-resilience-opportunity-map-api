class AddFieldsToGeometry < ActiveRecord::Migration[6.0]
  def change
    add_column :geometries, :state_fp, :integer
    add_column :geometries, :county_fp, :integer
    add_column :geometries, :geojson, :jsonb
    add_column :geometries, :properties, :jsonb

    add_index :geometries, :state_fp
    add_index :geometries, :county_fp
  end
end
