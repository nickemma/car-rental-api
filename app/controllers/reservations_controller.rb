class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @current_user
    if @reservation.save
      render json: @reservation
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def update
    unless @current_user == Reservation.find(params[:id]).user
      return render json: { error: 'You are not allowed' },
                    status: :unauthorized
    end

    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  def destroy
    unless @current_user == Reservation.find(params[:id]).user
      return render json: { error: 'You are not allowed' },
                    status: :unauthorized
    end

    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      render json: { id: @reservation.id, msg: 'Reservation deleted successfully' }
    else
      render json: { error: 'Something went wrong' }, status: :bad_request
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:reservation_date, :due_date, :car_id)
  end
end
