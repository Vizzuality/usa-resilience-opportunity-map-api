namespace :import do
  desc 'Import geometries from .json file'
  task :locations, [:types] => [:environment] do |t, args|
    types = args[:types].split(' ')
    ImportLocations.new(types).call
  end

  desc 'Import indicators'
  task indicators: :environment do
    ImportIndicators.new.call
  end

  desc 'Import Indicator Data'
  task indicator_data: :environment do
    ImportIndicatorData.new.call
  end
end
