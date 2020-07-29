class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :widget_type
      t.jsonb :source
      t.jsonb :config
      t.references :layer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :widgets, :name, unique: true
  end
end
