# Class to import the indicators from a json file
class ImportIndicators
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATORS <<<'

      file = Rails.root.join('db/files/indicators/indicators.json').open
      data = JSON.load file

      data['group'].each do |k, v|
        category = Category.find_or_create_by! name: v
        layer = data['indicator']["#{k}"]
        Layer.find_or_create_by! name: layer, category: category
        Indicator.find_or_create_by! name: layer
      end

      puts '>>> FINISHED IMPORTING INDICATORS <<<'
    end
  end
end