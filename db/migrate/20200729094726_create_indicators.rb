class CreateIndicators < ActiveRecord::Migration[6.0]
  def change
    create_table :indicators do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps

      t.index :name
    end
  end
end
