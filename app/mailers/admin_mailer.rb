class AdminMailer < ApplicationMailer
  default to: 'admin@gameplan.com' # Change admin email here.

  def subscription_confirmation(subscription)
    @subscription = subscription
    mail(subject: "A user #{@subscription.user.email} has subcribed a plan")
  end
end
