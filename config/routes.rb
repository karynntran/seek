Rails.application.routes.draw do

  root 'static#index'

  get '/result' => 'static#show'

  get '/autocomplete' => 'static#autocomplete'

  get '/photos' => 'static#photos'

  resources :users

end
