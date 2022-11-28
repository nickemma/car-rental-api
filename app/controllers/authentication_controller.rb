class AuthenticationController < ApplicationController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:email])
    return render json: { error: 'Invalid email or password' }, status: :unauthorized unless user

    if user.authenticate(params[:password])
      render json: user
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
