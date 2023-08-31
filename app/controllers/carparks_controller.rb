class CarparksController < ApplicationController
  def get_nearest_availabilities
    get_service_respone(__method__.to_s)
  end

  # donot change below method, just add new controllers above and implement new interaction in services with same name.
  def get_service_respone(request)
    api_request = request.camelize.constantize.run(params.to_h.as_json.deep_symbolize_keys)

    if api_request.errors.present?
      render json: { errors: api_request.errors.full_messages }, status: :bad_request
    end

    render json: api_request.result, status: :ok
  end
end
