class AuthenticationController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])
    if user.authenticate(params[:user][:password])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ['Invalid email or password'] }
    end
  end
end
