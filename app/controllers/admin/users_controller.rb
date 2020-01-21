class Admin::UsersController < Admin::AdminsController

  def index
    @users = User.page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully Created.'}
      else
        format.html { render :new }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @subscriptions = @user.subscriptions.active.order_by_created_at_desc
  end

  def recently_joined
    @users = if params[:joined] == 'today'
      User.joined(Date.today)
    elsif params[:joined] == 'month'
      User.joined(Date.today - 30.days)
    end

    respond_to do |format|
      format.js { render layout: false, action: 'recently_joined' }
    end
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:users)
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name)
    end

end

