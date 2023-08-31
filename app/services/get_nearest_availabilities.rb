class GetNearestAvailabilities < ActiveInteraction::Base
  float :latitude
  float :longitude
  integer :page_limit, default: 10
  integer :page, default: 1
  integer :max_distance, default: 1000000000

  def execute
    query = get_query

    data = get_data(query)
    pagination_data = get_pagination_data(query)

    return { list: data }.merge!(pagination_data)
  end

  def get_query
    Carpark
    .joins(:availability)
    .near([self.latitude, self.longitude], self.max_distance)
    .where.not(carpark_availabilities: { available_lots: 0 })
    .page(self.page)
    .per(self.page_limit)
    .select('carparks.address, carparks.latitude, carparks.longitude')
  end

  def get_pagination_data(query)
    {
      page: self.page,
      total: query.total_pages,
      total_count: query.total_count,
      page_limit: self.page_limit
    }
  end

  def get_data(query)
    data = query.includes(:availability).select('
      carparks.address,
      carparks.latitude,
      carparks.longitude,
      carpark_availabilities.total_lots,
      carpark_availabilities.available_lots')


    data.as_json(only: [
      :address,
      :latitude,
      :longitude,
      :total_lots,
      :available_lots,
      :distance
    ]).each {|t| t['distance'] = t['distance'].round(2)}
    .map(&:deep_symbolize_keys)
  end
end
