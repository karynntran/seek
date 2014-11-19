Rails.application.routes.draw do

  root 'static#index'

  resources :photos, only: [ :index]

  resources :users

end
