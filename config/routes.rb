Rails.application.routes.draw do

  root 'static#index'

  get '/:query' => 'static#show'

  resources :users

end
