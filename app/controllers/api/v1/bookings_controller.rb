class Api::V1::BookingsController < Api::V1::BaseController
  def index
    bookings = @current_user.bookings
    render(
      json: {
        success: true,
        data: bookings.map{ |b| Api::V1::BookingSerializer.new(b, root: false)},
        errors: []
      },
      status: 201
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
    @current_user.bookings.destroy_all
    render(
      json: {
        success: true,
        errors: []
      },
      status: 200
    )
  end
end