class PlansController < UsersController

  def index
    @plans = Plan.active.external.available_monthly
  end

  def available_monthly_yearly
    if params['monthly_yearly'] == 'yearly'
      @plans = Plan.active.external.available_annually
    else
      @plans = Plan.active.external.available_monthly
    end
    @monthly_yearly = params['monthly_yearly']
    respond_to do |format|
      format.js { render layout: false, action: 'available_monthly_yearly' }
    end
  end

  private
    def set_breadcrumb_menu
      breadcrumb(:plans)
      sub_menu(:plans)
    end
end
