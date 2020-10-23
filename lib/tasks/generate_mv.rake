namespace :mv do
  desc 'Create MV'
  task indicator_data: :environment do
    CreateMvService.new.call
  end
end
