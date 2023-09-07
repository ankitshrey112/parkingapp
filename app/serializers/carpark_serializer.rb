class CarparkSerializer < ActiveModel::Serializer
  attributes :address, :latitude, :longitude, :total_lots, :available_lots, :distance

  def distance
    object.distance.round(2)
  end
end
