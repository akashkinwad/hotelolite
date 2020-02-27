class FarmsController < UsersController
  before_action :set_farm

  def edit;end

  def title
    update
  end

  def description
    update
  end

  def contact_info
    update
  end

  def details
    update
  end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_path(@farm), notice: 'farm details were saved successfully.'
    else
      redirect_to edit_farm_path(@farm), error: 'Error in saving farm details.'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        :title,
        :description,
        :contact_no,
        :altr_contact_no,
        :address,
        :no_of_rooms,
        :area,
        :food_type,
        :time_to_visit,
        :email,
        :owner_name
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farms)
    end

    def set_farm
      @farm = current_user.farm
    end
end
