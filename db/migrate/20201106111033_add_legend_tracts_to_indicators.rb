class AddLegendTractsToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :legend_tracts, :string, array: true, default: []
  end
end
