class AddFieldsToIndicatorData < ActiveRecord::Migration[6.0]
  def change
    add_column :indicator_data, :absolute_value, :float
    add_column :indicator_data, :normalized_value, :float
    add_column :indicator_data, :range, :string
  end
end
