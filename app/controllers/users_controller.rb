class UsersController < ApplicationController
  skip_before_action :authenticate_token!

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :date_of_birth, :avatar)
  end
end
