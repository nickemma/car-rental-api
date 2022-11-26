Rails.application.routes.draw do
  post :auth, to: 'authentication#create'

  resources :users, only: [:create]
  resources :cars, only: [:index, :create, :destroy]
  resources :reservations, only: [:create, :destroy]

end
