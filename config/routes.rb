Rails.application.routes.draw do

  root 'search#index'

  get '/autocomplete' => 'search#autocomplete'

  get '/result' => 'results#show'

  resources :users

  patch 'check_favorites' => 'users#check_favorites'
  patch 'add_favorites' => 'users#add_favorites'

  resources :sessions, :only => [:new, :create, :destroy]

  get '/login' => "sessions#new"
end
