class WelcomeController < ApplicationController
  layout 'welcome'

  before_action :set_breadcrumb_menu

  def index
    @farm = Farm.first
    @farms = Farm.active
    @featured_farms = Farm.active.featured
  end

  def show
    @farm = Farm.friendly.find(params[:id])
  end

  def search
    @farms = if params.present?
      if params[:category_id].present?
        Farm.joins(:categories).where("farm_categories.id IN (params[:category_id])")
      elsif params[:title].present?
        Farm.where('title LIKE ?', "%#{params[:title]}%")
      elsif params[:city_id].present?
        Farm.where(city_id: params[:city_id])
      else
        Farm.active
      end
    else
      Farm.active
    end
    @farm = Farm.first
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:subscriptions)
    end

end
