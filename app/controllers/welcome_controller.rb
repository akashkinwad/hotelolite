class WelcomeController < ApplicationController
  layout 'welcome'

  before_action :set_breadcrumb_menu

  def index
    @farm = Farm.first
  end

  def show
    @farm = Farm.friendly.find(params[:id])
  end

  def search
    @farm = Farm.first
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:subscriptions)
    end

end
