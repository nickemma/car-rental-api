Rails.application.routes.draw do
  post :auth, to: 'authentication#create'
  post :toggle_admin, to: 'users#toggle_admin'

  resources :users, except: [:new, :edit, :show]
  resources :cars, except: [:new, :edit, :show]
  resources :reservations, only: [:create, :destroy]

end
