class AddBboxToGeometries < ActiveRecord::Migration[6.0]
  def change
    add_column :geometries, :bbox, :jsonb
  end
end
