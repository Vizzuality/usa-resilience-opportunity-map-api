class AddFieldsToIndicator < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :legend_states, :string,  array: true, default: []
    add_column :indicators, :legend_countries, :string,  array: :true, default: []
    add_column :indicators, :legend_title, :string
  end
end
