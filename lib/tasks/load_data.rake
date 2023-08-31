namespace :load do
  desc 'Import carparks information'
  task :import_carparks_information => :environment do
    ImportCarparkInformation.run!()
  end

  desc 'Import carparks availability'
  task :update_carpark_availabilities => :environment do
    UpdateCarparkAvailabilities.run!()
  end
end
