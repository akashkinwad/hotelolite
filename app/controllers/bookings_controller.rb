class BookingsController < UsersController

  def index
    @bookings = current_user.bookings
  end

  def destroy
    @booking = Booking.find_by_id(params[:id])
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:bookings)
    end
end
