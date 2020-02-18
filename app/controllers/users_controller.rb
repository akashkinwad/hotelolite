class UsersController < ApplicationController
  layout 'common_theme'

  before_action :authenticate_user!
  before_action :set_breadcrumb_menu

  def show
    @user = current_user
    @subscriptions = @user.subscriptions.active.order_by_created_at_desc
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'User was Successfuly Updated.' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end

    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:subscriptions)
    end

end
