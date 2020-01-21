class Admin::AdminsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_breadcrumb_menu

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_dashboard_index_path, notice: 'Admin was Successfully Updated.' }
        format.json { render :index, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def admin_params
      params.require(:admin).permit(:first_name, :last_name)
    end

    def set_breadcrumb_menu
      breadcrumb(:dashboard)
    end

end
