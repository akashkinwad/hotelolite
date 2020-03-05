class FarmLocationController < UsersController
  before_action :set_farm

  def edit; end

  def update
    if @farm.update(farm_params)
      update_lat_long
      redirect_to edit_farm_location_path(@farm), notice: 'Rates were added successfully.'
    else
      redirect_to edit_farm_location_path(@farm), error: 'Error in adding rates'
    end
  end

  private
    def farm_params
      params.require(:farm).permit(
        :latitude, :longitude, :map_iframe
      )
    end

    def set_breadcrumb_menu
      breadcrumb(:farm_location)
    end

    def set_farm
      @farm = current_user.farm
    end

    def ip_address
      if Rails.env.production?
        request.remote_ip
      else
        Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      end
    end

    def lat_lng
      service = GeocoderService.new(ip: ip_address)
      service.formatted_lat_lng
    end

    def update_lat_long
      @farm.latitude = lat_lng[:lat]
      @farm.longitude = lat_lng[:lng]
      @farm.save
    end
end
