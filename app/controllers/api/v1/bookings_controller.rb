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
    @booking = Booking.find_by_id(params[:id])
  end
end