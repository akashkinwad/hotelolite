class FarmSectionsController < UsersController
  before_action :set_farm

  def show;
    @farm.sections.build.sub_sections.build
  end

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_section_path(@farm), notice: 'Sections were added successfully.'
    else
      redirect_to edit_farm_section_path(@farm), error: 'Error in saving sections'
    end
    # respond_to do |format|
    #   format.js { render layout: false, action: 'create' }
    # end
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
