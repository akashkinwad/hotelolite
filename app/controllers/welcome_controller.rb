class WelcomeController < ApplicationController
  layout 'welcome'

  before_action :set_breadcrumb_menu

  def index

  end

  private

    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:subscriptions)
    end

end
