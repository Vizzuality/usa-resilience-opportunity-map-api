namespace :import do
  desc 'Import geometries from .json file'
  task :locations, :environment do
    ImportLocations.new.call
  end

  desc 'Import indicators'
  task indicators: :environment do
    ImportIndicators.new.call
  end
end
