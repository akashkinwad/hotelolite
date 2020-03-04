class Admin::TestimonialsController < Admin::AdminsController
  before_action :set_testimonial, only: [:edit, :update, :destroy]

  def index
    @testimonials = Testimonial.all.page(params[:page]).per(20)
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    if Testimonial.create(testimonial_params)
      redirect_to admin_testimonials_path, notice: 'Testimonial was added successfully.'
    else
      redirect_to admin_testimonials_path, error: 'Error in adding testimonial'
    end
  end

  def edit;end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to admin_testimonials_path, notice: 'Testimonial was added successfully.'
    else
      redirect_to admin_testimonials_path, error: 'Error in adding testimonial'
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to admin_testimonials_path, notice: 'Testimonial was deleted successfully.'
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:name, :text)
  end

  def set_breadcrumb_menu
    breadcrumb(:testimonials)
  end
end
