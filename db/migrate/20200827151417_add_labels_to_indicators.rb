class AddLabelsToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :labels, :string, array: true, default: []
    add_index :indicators, :labels
  end
end
