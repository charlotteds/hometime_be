class Api::V1::ReservationsController < ApplicationController
  def create
    guest = Guest.find_by(email: guest_params[:email]) || Guest.new(guest_params)
    reservation = guest.reservations.new(reservation_params)
    ActiveRecord::Base.transaction do
      guest.save! && reservation.save!
      render json: reservation, status: :created
    end

    rescue ActiveRecord::RecordInvalid
      render json: reservation, adapter: :json_api,
        serializer: ErrorSerializer,
        status: :unprocessable_entity
  end

  def update
    reservation = Reservation.find_by(code: reservation_params[:code])
    raise NoRecordError unless reservation.present?
    reservation.update!(reservation_params)
    render json: reservation, status: :ok

    rescue NoRecordError
      render json: reservation, adapter: :json_api,
        serializer: ErrorSerializer,
        status: :unprocessable_entity
  end

  private
  def guest_params
    ActionController::Parameters.new(sanitized_params[:guest]).permit(:first_name, :last_name, :email,
      phone_numbers_attributes: [:id, :value]
    )
  end

  def reservation_params
    ActionController::Parameters.new(sanitized_params[:reservation]).permit(
      :code, :start_date, :end_date, :nights, :guests_count, :adults_count, :children_count, :infants_count,
      :status, :currency, :payout_price, :security_price, :total_price
    )
  end

  def sanitized_params
    Api::V1::ParseReservationParamsService.new(raw_params).perform
  end
end
