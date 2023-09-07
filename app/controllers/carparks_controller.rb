class CarparksController < ApplicationController
  SUCCESS = 'OK'
  BAD_REQUEST = '400 Bad Request'

  def health
    render json: { status: SUCCESS }, status: :ok
  end

  def get_nearest_availabilities
    get_service_respone(__method__.to_s)
  end

  private

  # donot change below method, just add new controllers above and implement new interaction in services with same name.
  def get_service_respone(request)
    interaction = request.camelize.constantize
    @required_params = interaction.new.inputs.keys.map(&:to_sym)

    api_request = interaction.run(self.permitted_params.to_h.as_json.deep_symbolize_keys)

    serializer_class = "#{request}_serializer".camelize.constantize

    if api_request.errors.present?
      render json: { status: BAD_REQUEST, messages: api_request.errors.full_messages }, status: :bad_request
    else
      render json: api_request.result, serializer: serializer_class, status: :ok
    end
  end

  def permitted_params
    params.permit(@required_params)
  end
end
