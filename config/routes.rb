Rails.application.routes.draw do

  root 'search#index'

  get '/autocomplete' => 'search#autocomplete'

  get '/result' => 'results#show'

  resources :users, :only => [:show, :new, :create, :destroy]

  # This looks to me like it could be more RESTful.
  # In addition, URLs should have dashes, not underscores.
  patch '/check_favorites' => 'favorites#check_favorites'
  patch '/add_favorites' => 'favorites#add_favorites'
  patch '/delete_favorites' => 'favorites#delete_favorites'
  delete '/destroy' => 'favorites#destroy'

  resources :sessions, :only => [:new, :create]

  # Why not put that in line 17?
  delete '/sessions' => 'sessions#destroy'

  get '/login' => "sessions#new"

  # get '/check-user'  instead, maybe?
  get '/checkuser' => "sessions#check"
end
