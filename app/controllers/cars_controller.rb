class CarsController < ApplicationController
  skip_before_action :authenticate_token!, only: [:index]

  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @car = Car.new(car_params)
    if @car.save
      render json: @car
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def destroy
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @car = Car.find(params[:id])
    if @car.destroy
      render json: { id: @car.id, msg: 'Car deleted successfully' }
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def update
    return render json: { error: 'You are not allowed' }, status: :unauthorized unless @current_user.admin?

    @car = Car.find(params[:id])
    if @car.update(car_params)
      render json: @car
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :description, :brand, :daily_rate, :car_type, :image)
  end
end
