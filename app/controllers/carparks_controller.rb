class CarparksController < ApplicationController
  def get_nearest_availabilities
     @service_response = GetNearestAvailabilities.new.call(params)

     render json: @service_response, status: :ok
  end

  def build_response(service_response)

  end
end