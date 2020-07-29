class CreateIndicatorData < ActiveRecord::Migration[6.0]
  def change
    create_table :indicator_data do |t|
      t.integer :hazard_value
      t.references :geometry, null: false, foreign_key: true
      t.references :indicator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
