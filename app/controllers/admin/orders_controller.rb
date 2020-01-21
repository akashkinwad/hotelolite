class Admin::OrdersController < Admin::AdminsController

  def index
    @orders = Order.page(params[:page]).per(20)
  end

  private
  def set_breadcrumb_menu
    breadcrumb(:orders)
  end
end
