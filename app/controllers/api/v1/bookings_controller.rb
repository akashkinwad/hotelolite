class Api::V1::BookingsController < Api::V1::BaseController
  before_action :set_farm, only: :destroy_all

  def index
    bookings = @current_user.bookings
    render(
      json: {
        success: true,
        data: bookings.map{ |b| Api::V1::BookingSerializer.new(b, root: false)},
        errors: []
      },
      status: 200
    )
  end

  def destroy
    @booking = @current_user.bookings.find_by(id: params[:id])
    if @booking && @booking.destroy
      render(
        json: {
          success: true,
          errors: []
        },
        status: 200
      )
    else
      render(
        json: { success: false },
        status: :unprocessable_entity
      )
    end
  end

  def destroy_all
    @farm.bookings.destroy_all
    render(
      json: {
        success: true,
        errors: []
      },
      status: 200
    )
  end

  private

  def set_farm
    @farm = @current_user.farm
  end
end