class FarmSectionsController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_section_path(@farm), notice: 'Sections were added successfully.'
    else
      redirect_to edit_farm_section_path(@farm), error: 'Error in saving sections'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        sections_attributes: [:id, :name, :_destroy,
          sub_sections_attributes: [:id, :title, :description, :_destroy]
        ]
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_sections)
    end

    def set_farm
      @farm = current_user.farm
    end
end
