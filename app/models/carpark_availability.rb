class CarparkAvailability < ApplicationRecord
  belongs_to :carpark, class_name: "Carpark", :foreign_key => :carpark_number, :primary_key => :carpark_number

  validates_uniqueness_of :carpark_number
end
