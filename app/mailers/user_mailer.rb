class UserMailer < ApplicationMailer
  def subscription_confirmation(subscription)
    @subscription = subscription
    mail(
      to: @subscription.user.email,
      subject: 'Successfully subscribe to plan'
    )
  end

  def notify_about_subscription_expiry(subscription)
    @subscription = subscription
    mail(
      to: @subscription.user.email,
      subject: 'Your subscription for plan is about to expire tommorrow.'
    )
  end

  def deactivate_subscription_expiring_today(subscription)
    @subscription = subscription
    mail(
      to: @subscription.user.email,
      subject: 'Your subscription for plan is expire today.'
    )
  end
end
