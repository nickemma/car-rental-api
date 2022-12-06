class UsersController < ApplicationController
  skip_before_action :authenticate_token!, only: [:create]

  def index
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @users = User.all
    render json: @users
  end

  def toggle_admin
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @user = User.find(params[:id])
    if @user.toggle!(:admin)
      render json: @user
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

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

  def destroy
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @user = User.find(params[:id])
    if @user.destroy
      render json: { id: @user.id, msg: 'User deleted successfully' }
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :date_of_birth, :avatar)
  end
end
