require 'csv'

class IngestCarparkInformation < ActiveInteraction::Base
  def execute
    delete_carparks

    write_records_to_db

    return {
      records_read: @total_lines
    }
  end

  def write_records_to_db
    file_path = self.get_file_path

    @total_lines = 0

    CSV.foreach(file_path, headers: true, encoding: 'iso-8859-1:utf-8') do |record|
      write_record_to_db(record)

      @total_lines += 1
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{@total_lines}"
    end
  end

  def delete_carparks
    Carpark.delete_all
  end

  def write_record_to_db(record)
    record = record.to_h.deep_symbolize_keys

    carpark = Carpark.new(get_create_params(record))

    unless carpark.save
      puts carpark.errors.full_messages
    end
  end

  def get_file_path
    Rails.root.join('tmp', "carpark_information.csv")
  end

  def get_create_params(record)
    {
      carpark_number: record[:car_park_no].to_s,
      address: record[:address].to_s,
      latitude: record[:x_coord].to_f.round(4),
      longitude: record[:y_coord].to_f.round(4),
      carpark_type: record[:carpark_type].to_s,
      type_of_parking_system: record[:type_of_parking_system].to_s,
      short_term_parking: record[:short_term_parking].to_s,
      free_parking: record[:free_parking].to_s,
      night_parking: record[:night_parking].to_s,
      car_park_decks: record[:car_park_decks].to_i,
      gantry_height: record[:gantry_height].to_f.round(4),
      car_park_basement: record[:car_park_basement].to_s,
    }
  end
end
