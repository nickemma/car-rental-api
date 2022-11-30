Rails.application.routes.draw do
  post :auth, to: 'authentication#create'
  post :register, to: 'users#create'
  post :toggle_admin, to: 'users#toggle_admin'

  resources :users, only: [:destroy, :update, :index]
  resources :cars, except: [:new, :edit, :show]
  resources :reservations, only: [:create, :destroy]

end
