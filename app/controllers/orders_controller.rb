class OrdersController < UsersController

  def index
    @user = current_user
    @orders = @user.orders.page(params[:page]).per(20)
  end

  def show
    @user = current_user
    @order = @user.orders.find(params[:id])
  end

  private

  def set_breadcrumb_menu
    breadcrumb(:plans)
    sub_menu(:orders)
  end

end

