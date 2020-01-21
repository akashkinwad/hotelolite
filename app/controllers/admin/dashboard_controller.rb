class Admin::DashboardController < Admin::AdminsController

  def index
    @recent_activities = RecentActivity.todays.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

    def set_breadcrumb_menu
      breadcrumb(:dashboard)
    end

end
