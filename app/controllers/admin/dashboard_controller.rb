class Admin::DashboardController < Admin::AdminsController

  def index
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:dashboard)
    end

end
