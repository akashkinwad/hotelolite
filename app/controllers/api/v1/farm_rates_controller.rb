class Api::V1::FarmRatesController < Api::V1::BaseController
  before_action :set_farm, :find_rates

  def show
    render(
      json: {
        success: true,
        data: @farm_rates.map{ |rate| Api::V1::FarmRateSerializer.new(rate, root: false)},
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
          data: @farm_rates.map{ |rate| Api::V1::FarmRateSerializer.new(rate, root: false)},
          errors: []
        },
        status: 201
      )
    else
      render(
        json: {
          success: false,
          data: @farm_rates.map{ |rate| Api::V1::FarmRateSerializer.new(rate, root: false)},
          errors: @farm.errors.full_messages
        },
        status: :unprocessable_entity
      )
    end
  end

  private
    def farm_params
      params.permit(rates_attributes: [:id, :title, :amount, :_destroy])
    end

    def set_farm
      @farm = @current_user.farm
    end

    def find_rates
      @farm_rates = @farm.rates
    end
end