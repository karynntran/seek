Rails.application.routes.draw do

  root 'static#index'

  get '/result' => 'static#show'

  get '/autocomplete' => 'static#autocomplete'

  resources :users

  resources :sessions, :only => [:new, :create, :destroy]

  get '/login' => "sessions#new"
end
