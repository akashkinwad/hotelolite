class FarmsController < UsersController

  before_action :set_farm

  def show;end

  def update
    @farm.update(farm_params)
    respond_to do |format|
      format.js { render layout: false, action: 'create' }
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        :title,
        :description,
        :contact_no,
        :altr_contact_no,
        :district,
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farms)
    end

    def set_farm
      @farm = current_user.farm
    end
end
