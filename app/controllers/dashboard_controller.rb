class DashboardController < UsersController

  def index
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:dashboard)
    end
end
