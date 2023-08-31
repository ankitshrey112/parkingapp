Rails.application.routes.draw do
  root 'carparks#health'

  get 'carparks/nearest', to: 'carparks#get_nearest_availabilities'
end
