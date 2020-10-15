class AddParentIdToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :external_id, :integer
    add_reference :indicators,:parent, foreign_key: { to_table: :indicators }
  end
end
