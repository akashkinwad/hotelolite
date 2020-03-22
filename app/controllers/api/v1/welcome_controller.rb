class Api::V1::WelcomeController < Api::V1::ApiController
  before_action :set_farm, only: [:show, :booking]

  def index
    farms = Farm.with_eager_loaded_images.active
    render(
      json: {
        success: true,
        data: farms.map{ |farm| Api::V1::FarmSerializer.new(farm, root: false)},
        errors: []
      },
      status: 201
    )
  end

  def show
    if @farm.present?
      render(
        json: {
          success: true,
          data: JSON.parse(Api::V1::FarmSerializer.new(@farm, root: false).to_json),
          errors: []
        },
        status: 200
      )
    else
      render(
        json: {
          success: false,
          errors: ['Not found']
        },
        status: 302
      )
    end
  end

  def featured
    farms = Farm.with_eager_loaded_images.active.featured
    render(
      json: {
        success: true,
        data: farms.map{ |farm| Api::V1::FarmSerializer.new(farm, root: false)},
        errors: []
      },
      status: 201
    )
  end

  def search
    farms = if params.present?
      if params[:category_id].present?
        Farm.with_eager_loaded_images.joins(:categories).where("categories.id IN (#{params[:category_id]})")
      elsif params[:title].present?
        Farm.with_eager_loaded_images.where('title LIKE ?', "%#{params[:title]}%")
      elsif params[:city_id].present?
        Farm.with_eager_loaded_images.where(city_id: params[:city_id])
      else
        Farm.with_eager_loaded_images.active
      end
    else
      Farm.with_eager_loaded_images.active
    end
    render(
      json: {
        success: true,
        data: farms.map{ |farm| Api::V1::FarmSerializer.new(farm, root: false)},
        errors: []
      },
      status: 201
    )
  end

  def booking
    booking = @farm.bookings.new(booking_params)
    if booking.save
      render(
        json: { success: true, errors: [] },
        status: 200
      )
    else
      render(
        json: {
          success: false,
          errors: booking.errors.full_messages
        },
        status: :unprocessable_entity
      )
    end
  end

  def testimonials
    testimonials = Testimonial.all
    render(
      json: {
        success: false,
        data: testimonials.map{ |test| Api::V1::TestimonialsSerializer.new(test, root: false)},
        errors: []
      },
      status: 201
    )
  end

  private
    def set_farm
      @farm = Farm.friendly.find_by(id: params[:id])
    end

    def booking_params
      params.require(:booking).permit(
        :first_name, :last_name, :email,
        :contact_no, :altr_contact_no, :check_in,
        :farm_id
      )
    end
end