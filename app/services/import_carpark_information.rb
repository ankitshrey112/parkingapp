require 'csv'
require 'svy21'

class ImportCarparkInformation < ActiveInteraction::Base
  def execute
    deactive_records

    write_records_to_db

    return {
      records_read: @total_lines
    }
  end

  def write_records_to_db
    file_path = self.get_file_path

    @total_lines = 0

    CSV.foreach(file_path, headers: true, encoding: 'iso-8859-1:utf-8') do |record|
      begin
        write_record_to_db(record)
      rescue => error
        puts error
      end

      @total_lines += 1
      puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{@total_lines}"
    end
  end

  def write_record_to_db(record)
    record = record.to_h.deep_symbolize_keys

    carpark_number = record[:car_park_no].present? ? record[:car_park_no].to_s : nil
    svy21_easting = Float(record[:x_coord]) rescue nil
    svy21_northing = Float(record[:y_coord]) rescue nil

    if svy21_easting.present? && svy21_northing.present?
      lat_lon = SVY21.svy21_to_lat_lon(svy21_easting, svy21_northing)

      latitude = lat_lon[0].round(6)
      longitude = lat_lon[1].round(6)

      print svy21_easting, ' ', svy21_northing, '->', latitude, ' ', longitude
    end

    carpark = Carpark.find_or_initialize_by({ carpark_number: carpark_number })

    carpark.latitude = latitude
    carpark.longitude = longitude
    carpark.carpark_type = record[:car_park_type].to_s
    carpark.type_of_parking_system = record[:type_of_parking_system].to_s
    carpark.short_term_parking = record[:short_term_parking].to_s
    carpark.free_parking = record[:free_parking].to_s
    carpark.night_parking = record[:night_parking].to_s
    carpark.car_park_decks = record[:car_park_decks].to_i
    carpark.gantry_height = record[:gantry_height].to_f.round(4)
    carpark.car_park_basement = record[:car_park_basement].to_s
    carpark.address = record[:address].to_s
    carpark.status = 'active'

    unless carpark.save
      puts carpark.errors.full_messages
    end
  end

  def deactive_records
    Carpark.update_all(status: 'inactive')
  end

  def get_file_path
    Rails.root.join('tmp', "carpark_information.csv")
  end
end
