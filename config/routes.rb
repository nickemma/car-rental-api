Rails.application.routes.draw do
  post :auth, to: 'authentication#create'
end
