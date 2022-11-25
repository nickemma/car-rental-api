class CarsControler < ApplicationController
  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  private

  def car_params
    params.permit(:name, :description, :brand, :daily_rate, :type, :image)
  end
end
