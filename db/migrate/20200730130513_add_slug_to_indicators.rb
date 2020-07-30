class AddSlugToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :slug, :string
    add_index :indicators, :slug
  end
end
