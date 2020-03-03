class BookingsController < UsersController
  helper_method :sort_direction

  def index
    bookings = current_user.bookings.page(params[:page]).per(10)
    if params[:sort] == 'created_at'
      @bookings = bookings.order("bookings.created_at #{sort_direction}")
    else
      @bookings = bookings
    end
  end

  def destroy
    @booking = Booking.find_by_id(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Successfully deleted message'
  end

  def destroy_all
    current_user.bookings.destroy_all
    redirect_to bookings_path, notice: 'Successfully deleted all messages'
  end

  private
    def set_breadcrumb_menu
      breadcrumb(:bookings)
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
