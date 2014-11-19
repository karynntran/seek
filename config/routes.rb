Rails.application.routes.draw do

  resources :photos, only: [ :index]

  resources :users

end
