class Api::V1::FarmsController < Api::V1::BaseController
  before_action :set_farm

  def show
    render(
      json: {
        success: true,
        data: JSON.parse(Api::V1::FarmSerializer.new(@farm, root: false).to_json),
        errors: []
      },
      status: 201
    )
  end

  def update
    if @farm.update(farm_params)
      render(
        json: {
          success: true,
          data: JSON.parse(Api::V1::FarmSerializer.new(@farm, root: false).to_json),
          errors: []
        },
        status: 201
      )
    else
      render(
        json: {
          success: false,
          data: JSON.parse(Api::V1::FarmSerializer.new(@farm, root: false).to_json),
          errors: @farm.errors.full_messages
        },
        status: :unprocessable_entity
      )
    end
  end

  private
    def farm_params
      params.permit(
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
        :owner_name,
        :facebook_url,
        :instagram_url,
        :whatsapp_no,
        :district_id,
        :map_iframe
      )
    end

    def set_farm
      @farm = @current_user.farm
    end
end