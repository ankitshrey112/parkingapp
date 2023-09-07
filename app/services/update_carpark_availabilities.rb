class UpdateCarparkAvailabilities < ActiveInteraction::Base
  
  #TODO PUT IN CREDENTIALS
  CARPARK_AVAILABILITY_URL = 'https://api.data.gov.sg/v1/transport/carpark-availability' 

  def execute
    response = get_response_from_client

    if response[:error].present?
      self.errors.add(base: response[:error])
      return
    end

    deactive_records

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
      begin
        write_record_to_db(carpark)
      rescue => error
        puts error
      end
    
      @total_lines += 1
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{@total_lines}"
    end
  end

  def deactive_records
    CarparkAvailability.update_all(status: 'inactive')
  end

  def write_record_to_db(record)
    total_lots = record[:carpark_info].pluck(:total_lots).map(&:to_i).sum(0)
    available_lots = record[:carpark_info].pluck(:lots_available).map(&:to_i).sum(0)

    carpark_number = record[:carpark_number].present? ? record[:carpark_number].to_s : nil
    available_lots = Integer(available_lots) rescue nil

    params = {
      carpark_number: carpark_number,
      total_lots: total_lots,
      available_lots: available_lots,
      update_datetime: record[:update_datetime]
    }

    carpark_availability = CarparkAvailability.find_or_initialize_by({ carpark_number: params[:carpark_number] })
    
    carpark_availability.total_lots = params[:total_lots]
    carpark_availability.available_lots = params[:available_lots]
    carpark_availability.update_datetime = params[:update_datetime]
    carpark_availability.status = 'active'

    unless carpark_availability.save
      puts carpark_availability.errors.full_messages
    end
  end
end
