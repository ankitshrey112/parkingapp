class UpdateCarparkAvailabilities < ActiveInteraction::Base
  
  #TODO PUT IN CREDENTIALS
  CARPARK_AVAILABILITY_URL = 'https://api.data.gov.sg/v1/transport/carpark-availability' 

  def execute
    response = get_response_from_client

    if response[:error].present?
      self.errors.add(base: response[:error])
      return
    end

    write_records_to_db(response)

    return {
      records_read: @total_lines
    }
  end

  def get_response_from_client
    begin
      api_response = RestClient.get(CARPARK_AVAILABILITY_URL)
      response = JSON.parse(api_response.body) if api_response.code == 200
    rescue => e
      response = {
        error: { errMsg: e }
      }
    end

    return response
  end

  def write_records_to_db(response)
    carparks = response['items'].first['carpark_data'].map(&:deep_symbolize_keys)

    @total_lines = 0

    carparks.each do |carpark|
      write_record_to_db(carpark)
      @total_lines += 1

      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{@total_lines}"
    end
  end

  def write_record_to_db(record)
    record[:carpark_info].each do |info|
      params = {
        carpark_number: record[:carpark_number],
        lot_type: info[:lot_type],
        total_lots: info[:total_lots],
        lots_available: info[:lots_available],
        update_datetime: record[:update_datetime]
      }

      carpark_availability = CarparkAvailability.new(params)

      unless carpark_availability.save
        puts carpark_availability.errors.full_messages
      end
    end
  end
end
