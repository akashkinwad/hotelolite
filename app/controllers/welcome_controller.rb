class WelcomeController < ApplicationController
  layout 'welcome'

  before_action :set_breadcrumb_menu
  before_action :set_farm, only: [:show, :enquiry, :booking, :gallery]

  def index
    @farm = Farm.first
    @farms = Farm.with_eager_loaded_images.active
    @featured_farms = Farm.with_eager_loaded_images.active.featured
  end

  def show
  end

  def search
    @farms = if params.present?
      if params[:category_id].present?
        Farm.joins(:categories).where("categories.id IN (#{params[:category_id]})")
      elsif params[:title].present?
        Farm.where('title LIKE ?', "%#{params[:title]}%")
      elsif params[:city_id].present?
        Farm.where(city_id: params[:city_id])
      else
        Farm.with_eager_loaded_images.active
      end
    else
      Farm.with_eager_loaded_images.active
    end
    @farm = Farm.first
  end

  def enquiry
    @booking = @farm.bookings.new
  end

  def booking
    @booking = @farm.bookings.new(booking_params)
    if @booking.save
      redirect_to enquiry_welcome_path(@farm)
    else
      redirect_to enquiry_welcome_path(@farm)
    end
  end

  def gallery
    @images = @farm.images
  end

  private
    def set_farm
      @farm = Farm.friendly.find(params[:id])
    end

    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:subscriptions)
    end

    def booking_params
      params.require(:booking).permit(
        :first_name, :last_name, :email,
        :contact_no, :altr_contact_no, :check_in
      )
    end
end
