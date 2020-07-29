class CreateMetadata < ActiveRecord::Migration[6.0]
  def change
    create_table :metadata do |t|
      t.string :title
      t.text :description
      t.jsonb :source
      t.jsonb :aditional
      t.jsonb :links
      t.references :layer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :metadata, :title
  end
end
