# Class to import the indicators from a json file
class ImportIndicators
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATORS <<<'

      file = Rails.root.join('db/files/indicators/indicators.json').open
      data = JSON.load file

      data.each do |ind|
        category = Category.find_or_create_by! name: ind['group']
        # Layer.find_or_create_by! name: ind['name'], category: category
        Indicator.find_or_create_by! name: ind['name'], slug: ind['slug']
      end

      puts '>>> FINISHED IMPORTING INDICATORS <<<'
    end
  end
end
