class FarmCategoriesController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_category_path(@farm), notice: 'Categories were added successfully.'
    else
      redirect_to edit_farm_category_path(@farm), error: 'Error in adding categories'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(category_ids: [])
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_categories)
    end

    def set_farm
      @farm = current_user.farm
    end
end
