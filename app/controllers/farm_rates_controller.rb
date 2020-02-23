class FarmRatesController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_rate_path(@farm), notice: 'Rates were added successfully.'
    else
      redirect_to edit_farm_rate_path(@farm), error: 'Error in adding rates'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        rates_attributes: [:id, :title, :amount, :_destroy]
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_rates)
    end

    def set_farm
      @farm = current_user.farm
    end
end
