module Admin::DashboardsHelper

  def total_users_count
    User.all.count
  end

  def total_active_subscriptions_count
    Subscription.active.count
  end

  def total_active_plans_count
    Plan.active.count
  end

  def total_ongoing_tournaments_count
    Tournament.ongoing.count
  end

  def hour_formatter(attribute)
    attribute.strftime("%H:%M")
  end
end
