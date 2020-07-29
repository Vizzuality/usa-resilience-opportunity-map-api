# Class to import the indicators from a json file
class ImportIndicators
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATORS <<<'

      puts '>>> FINISHED IMPORTING INDICATORS <<<'
    end
  end
end