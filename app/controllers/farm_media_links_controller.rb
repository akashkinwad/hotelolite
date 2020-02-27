class FarmMediaLinksController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_media_link_path(@farm), notice: 'Categories were added successfully.'
    else
      redirect_to edit_farm_media_link_path(@farm), error: 'Error in adding categories'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        :facebook_url,
        :instagram_url,
        :whatsapp_no
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_media_links)
    end

    def set_farm
      @farm = current_user.farm
    end
end
