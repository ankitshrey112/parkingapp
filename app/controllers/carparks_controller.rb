class CarparksController < ApplicationController
  def get_nearest_availabilities
    api_request = GetNearestAvailabilities.run(params.as_json.map(&:deep_symbolize_keys))

    if api_request.errors.present?
      render json: { errors: api_request.errors.full_messages }, status: :bad_request
    end

    render json: api_request.result, status: :ok
  end
end
