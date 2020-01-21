class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :resource, polymorphic: true, optional: true
  has_one :recent_activity, as: :resource, dependent: :destroy
  has_many :matches, through: :plan
  has_many :tournaments, through: :plan

  has_many :orders, dependent: :destroy

  validates :s_type, presence: { message: "Please select Subscription type" }

  scope :active, ->{ where(active: true) }
  scope :last_thirty_days, ->{ where("created_at >= ?", (Date.today - 30.days)) }
  scope :created_by, ->(resource_type){ where(resource_type: resource_type) }
  scope :order_by_created_at_desc, ->{ order('created_at DESC') }
  scope :expiring_today, ->{ where(end_time: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :expiring_tommorrow, ->{ where(end_time: (DateTime.tomorrow).beginning_of_day..(DateTime.tomorrow).end_of_day) }

  delegate :name, to: :plan, prefix: true, allow_nil: true

  before_create :copy_plans_attributes
  before_create :set_validity
  after_create :log_recent_activity

  class << self
    def recent
      if Rails.env == 'development'
        last_thirty_days.group("strftime('%Y-%m-%d', subscriptions.created_at)").count
      else
        last_thirty_days.group("date(subscriptions.created_at)").count
      end
    end

    def deactivate_expiring_today
     subscriptions = Subscription.expiring_today
      subscriptions.each do |subscription|
        UserMailer.deactivate_subscription_expiring_today(subscription).deliver_now
        subscription.update(active: false)
      end
    end

    def notify_user_about_subscription_expiry
      subscriptions = Subscription.expiring_tommorrow
      subscriptions.each do |subscription|
        UserMailer.notify_about_subscription_expiry(subscription).deliver_now
      end
    end
  end

  def user_name
    if user.first_name.present?
      user.full_name
    else
      user.email
    end
  end

  def price
    if s_type == 'yearly'
      plan.price_per_year
    else
      plan.price_per_month
    end
  end

  def process_payment
    customer = Stripe::Customer.create(
      email: stripe_email,
      card: stripe_token
    )
    Stripe::Charge.create(
      customer: customer,
      amount: price.to_i * 100,
      description: plan.name,
      currency: 'inr'
    )
  end

  def save_order_details
    orders.create(
      user_id: user.id,
      response: {
        paymentId: stripe_token,
        token: stripe_token,
      },
      info: {
        amount: price,
        payer_email: stripe_email,
        currency: 'inr',
        payment_method: 'Stripe'
      }
    )
  end

  def notifiy_user_and_admin
    UserMailer.subscription_confirmation(self).deliver_now
    AdminMailer.subscription_confirmation(self).deliver_now
  end

  private

    def set_validity
      free_trial_days = plan.free_trial_days
      self.start_time = DateTime.now + free_trial_days.days
      set_expiry_date
    end

    def set_expiry_date
      if s_type == 'monthly'
        self.end_time = start_time + 30.days
      else
        self.end_time = start_time + 365.days
      end
    end

    def log_recent_activity
      description = "#{user_name} has subscribed to #{plan_name}"
      self.create_recent_activity(description: description)
    end

    def copy_plans_attributes
      self.assign_attributes({
        price_per_month: plan.price_per_month,
        price_per_year: plan.price_per_year,
        calls_limit_per_hour: plan.calls_limit_per_hour,
        sports_type: plan.sports_type
      })
    end
end
