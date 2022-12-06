Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post :auth, to: 'authentication#create'
  post :register, to: 'users#create'
  put :toggle_admin, to: 'users#toggle_admin'

  resources :users, only: [:destroy, :update, :index]
  resources :cars, except: [:new, :edit, :show]
  resources :reservations, only: [:create, :destroy, :update]

end
