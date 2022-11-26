class CarsController < ApplicationController
  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    return render json: { errors: ['You are not allowed'] } unless @current_user.admin?

    @car = Car.new(car_params)
    if @car.save
      render json: @car
    else
      render json: { errors: ['Something went wrong'] }
    end
  end

  def destroy
    return render json: { errors: ['You are not allowed'] } unless @current_user.admin?

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
end
