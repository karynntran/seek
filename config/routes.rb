Rails.application.routes.draw do

  root 'search#index'

  get '/autocomplete' => 'search#autocomplete'

  get '/result' => 'results#show'

  resources :users, :only => [:show, :new, :create, :destroy]

  patch '/check_favorites' => 'favorites#check_favorites'

  patch '/add_favorites' => 'favorites#add_favorites'

  patch '/delete_favorites' => 'favorites#delete_favorites'


  resources :sessions, :only => [:new, :create]

  delete '/sessions' => 'sessions#destroy'

  get '/login' => "sessions#new"

  get '/checkuser' => "sessions#check"
end
