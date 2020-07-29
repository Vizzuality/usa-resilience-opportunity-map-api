class CreateLayers < ActiveRecord::Migration[6.0]
  def change
    create_table :layers do |t|
      t.string :name
      t.string :layer_type
      t.jsonb :source
      t.jsonb :render
      t.json :legend_config

      t.timestamps

      t.references :category, null: false, foreign_key: true
    end
    add_index :layers, :name, unique: true
    add_index :layers, :layer_type
  end
end
