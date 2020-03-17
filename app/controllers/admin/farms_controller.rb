class Admin::FarmsController < Admin::AdminsController
  before_action :set_farm, only: [:edit, :update, :destroy, :show]

  def index
    @farms = Farm.all.order(:id).page(params[:page]).per(20)
  end

  def show;end

  def edit;end

  def update
    if @farm.update(farm_params)
      redirect_to admin_farms_path, notice: 'Farm was added successfully.'
    else
      redirect_to admin_farms_path, error: 'Error in adding farm'
    end
  end

  def destroy
    @farm.destroy
    redirect_to admin_farms_path, notice: 'Farm was deleted successfully.'
  end

  private

  def set_farm
    @farm = Farm.friendly.find(params[:id])
  end

  def farm_params
    params.require(:farm).permit(
      :status, :is_featured, :reviews, :stars
    )
  end

  def set_breadcrumb_menu
    breadcrumb(:farms)
  end
end
