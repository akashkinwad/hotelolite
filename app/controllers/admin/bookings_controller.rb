class Admin::BookingsController < Admin::AdminsController

  def index
    @bookings = Booking.page(params[:page]).per(20)
  end

  private
  def set_breadcrumb_menu
    breadcrumb(:bookings)
  end
end
