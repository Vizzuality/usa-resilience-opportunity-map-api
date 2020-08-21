class AddRelevantToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :relevant, :boolean, default: false, null: :false
    add_index :indicators, :relevant
  end
end
