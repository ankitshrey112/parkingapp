Rails.application.routes.draw do
  get 'api/vehicles', to: 'carparks#get_nearest_availabilities'
end
