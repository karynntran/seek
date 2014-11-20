Rails.application.routes.draw do

  root 'static#index'

  get '/:query'

  resources :users

end
