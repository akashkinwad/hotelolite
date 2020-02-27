class FarmLocationController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_location_path(@farm), notice: 'Rates were added successfully.'
    else
      redirect_to edit_farm_location_path(@farm), error: 'Error in adding rates'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        :latitude, :longitude
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_location)
    end

    def set_farm
      @farm = current_user.farm
    end
end
