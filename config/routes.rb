Rails.application.routes.draw do
  get 'carparks/nearest', to: 'carparks#get_nearest_availabilities'
end
