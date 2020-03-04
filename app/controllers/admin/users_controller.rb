class Admin::UsersController < Admin::AdminsController
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).per(10)
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

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated'
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted'
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:users)
    end

    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name)
    end

    def find_user
      @user = User.find(params[:id])
    end

end

