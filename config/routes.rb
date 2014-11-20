Rails.application.routes.draw do

  root 'static#index'

  get '/result' => 'static#show'

  resources :users

end
