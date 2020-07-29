# Class to import the locations from a json file
class ImportLocations
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING LOCATIONS <<<'

      puts '>>> FINISHED IMPORTING LOCATIONS <<<'
    end
  end
end