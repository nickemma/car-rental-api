Rails.application.routes.draw do
  post :auth, to: 'authentication#create'

  resources :users, only: [:create]
  resources :cars, except: [:update, :edit, :new]
resources :reservations, only: [:create, :delete]


end
