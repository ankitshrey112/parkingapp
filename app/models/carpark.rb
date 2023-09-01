class Carpark < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  has_one :availability, class_name: "CarparkAvailability", :foreign_key => :carpark_number, :primary_key => :carpark_number, required: false

  validates_presence_of :carpark_number, :latitude, :longitude

  validates_uniqueness_of :carpark_number
end
