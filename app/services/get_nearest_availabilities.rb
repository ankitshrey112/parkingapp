class GetNearestAvailabilities < ActiveInteraction::Base
  float :latitide
  float :longitude

  def execute
    response = get_response
    
    return response
  end

  def get_response
    return []
  end
end
