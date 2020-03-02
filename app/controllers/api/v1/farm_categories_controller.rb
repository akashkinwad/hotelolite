class Api::V1::FarmCategoriesController < Api::V1::BaseController
  before_action :set_farm

  def show
    categories = @farm.categories
    render(
      json: {
        success: true,
        data: categories.map{ |rate| Api::V1::CategorySerializer.new(rate, root: false)},
        errors: []
      },
      status: 201
    )
  end

  def edit;end

  def update
    if @farm.update(farm_params)
      render(
        json: {
          success: true,
          data: @farm.category_ids,
          errors: []
        },
        status: 201
      )
    else
      render(
        json: {
          success: false,
          data: @farm.category_ids,
          errors: @farm.errors.full_messages
        },
        status: :unprocessable_entity
      )
    end
  end

  def categories
    categories = Category.all
    render(
      json: {
        success: true,
        data: categories.map{ |cat| Api::V1::CategorySerializer.new(cat, root: false)},
        errors: []
      },
      status: 201
    )
  end

  private
    def farm_params
      params.permit(category_ids: [])
    end

    def set_farm
      @farm = @current_user.farm
    end
end