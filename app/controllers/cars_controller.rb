class CarsController < ApplicationController
  before_action :check_admin?, only: [:create, :destroy]
  
  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      render json: @car
    else
      render json: { errors: ['Something went wrong'] }
    end
  end

  def destroy
    @car = Car.find(params[:id])
    if @car.destroy
      render json: { id: @car.id, message: 'Car deleted successfully' }
    else
      render json: { errors: ['Something went wrong'] }
    end
  end

  private

  def car_params
    params.permit(:name, :description, :brand, :daily_rate, :car_type, :image)
  end

  def check_admin?
    @current_user.admin?
  end
end
