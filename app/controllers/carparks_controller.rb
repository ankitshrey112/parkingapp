class CarparksController < ApplicationController
  def get_nearest_availabilities
     service_response = GetNearestAvailabilities.run(params.as_json.map(&:deep_symbolize_keys))

     result = service_response.result

     render json: result, status: :ok
  end
end
