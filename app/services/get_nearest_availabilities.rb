class GetNearestAvailabilities < ActiveInteraction::Base
  float :latitide
  float :longitude

  def execute
    return {
      list: []
    }
  end
end
