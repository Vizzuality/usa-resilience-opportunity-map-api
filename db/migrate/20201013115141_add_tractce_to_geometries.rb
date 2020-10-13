class AddTractceToGeometries < ActiveRecord::Migration[6.0]
  def change
    add_column :geometries, :tract_ce, :integer
  end
end
