class FarmImagesController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      redirect_to edit_farm_image_path(@farm), notice: 'Images were added successfully.'
    else
      redirect_to edit_farm_image_path(@farm), error: 'Error in adding Images'
    end
  end

  def destroy
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to edit_farm_image_path(@farm), notice: 'Successfully deleted image'
  end

  private
    def farm_params
      params.require(:farm).permit(images: [])
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_images)
    end

    def set_farm
      @farm = current_user.farm
    end
end
