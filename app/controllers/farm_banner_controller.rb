class FarmBannerController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_banner_path(@farm), notice: 'Banner were added successfully.'
    else
      redirect_to edit_farm_banner_path(@farm), error: 'Error in adding banner image.'
    end
  end

  def destroy
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to edit_farm_banner_path(@farm), notice: 'Successfully deleted banner'
  end

  private
    def farm_params
      params.require(:farm).permit(:banner)
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_banner)
    end

    def set_farm
      @farm = current_user.farm
    end
end
