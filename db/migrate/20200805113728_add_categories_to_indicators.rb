class AddCategoriesToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_reference :indicators, :category, index: true
  end
end
