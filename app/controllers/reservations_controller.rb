class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @current_user
    if @reservation.save
      render json: @reservation
    else
      render json: { errors: ['Something went wrong'] }
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      render json: { id: @reservation.id, message: 'Reservation deleted successfully' }
    else
      render json: { errors: ['Something went wrong'] }
    end
  end

  private

  def reservation_params
    params.permit(:reservation_date, :due_date, :car_id)
  end
end
