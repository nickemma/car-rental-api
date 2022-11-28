class UsersController < ApplicationController
  skip_before_action :authenticate_token!, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      render json: @user
    else
      render json: { error: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :date_of_birth, :avatar)
  end
end
