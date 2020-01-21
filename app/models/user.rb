class User < ApplicationRecord
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # validates :email, presence: true, uniqueness: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :subscriptions
  has_many :active_subscriptions, ->{ where(active: true) }, class_name: 'Subscription'
  has_many :active_matches, through: :active_subscriptions, class_name: 'Match', source: :matches
  has_many :matches, through: :subscriptions
  has_many :tournaments
  has_many :plans, through: :subscriptions
  has_many :api_tokens, dependent: :destroy
  has_many :payment_details, dependent: :destroy
  has_many :api_calls, dependent: :destroy
  has_one :recent_activity, as: :resource
  has_many :orders


  # validates :first_name, presence: true, length: { minimum: 2 }, unless: ->{ new_record? }
  # validates :last_name, presence: true, length: { minimum: 2 }, unless: ->{ new_record? }

  scope :joined, ->(date){ where("created_at >= ?", date) }

  after_create :log_recent_activity

  def self.created_on_date_count
    if false
      User.group("strftime('%Y-%m-%d', users.created_at)").count
    else
      User.group("DATE_FORMAT(users.created_at, '%Y-%m-%d')").count
    end
  end

  def user_name
    first_name.present? ? first_name : email
  end

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  def name_abbrivation
    user_name.chr.upcase
  end

  def call_per_day
    call_per_day_hash = if false
      api_calls.today.group("strftime('%Y-%m-%d', api_calls.created_at)").count
    else
      api_calls.today.group("DATE_FORMAT(api_calls.created_at, '%Y-%m-%d')").count
    end
    call_per_day_hash.empty? ? 0 : call_per_day_hash.values.last
  end

  def call_per_day_per_hour
    if false
      api_calls.today.group("strftime('%Y-%m-%d-%H', api_calls.created_at)").count
    else
      api_calls.today.group("DATE_FORMAT(api_calls.created_at, '%d-%H')").count
    end
  end

  def call_per_hour_per_minute
    if false
      api_calls.today.group("strftime('%H-%M', api_calls.created_at)").count
    else
      api_calls.today.group("DATE_FORMAT(api_calls.created_at, '%H:%i')").count
    end
  end

  def api_calls_this_hour
    calls_hash = call_per_hour_per_minute
    calls_hash.select {|k,v| k.to_s.match(/^#{Time.now.hour}/)}
  end

  def total_requests_in_hour
    call_per_day_hash = if false
      api_calls.today.group("strftime('%Y-%m-%d-%H', api_calls.created_at)").count
    else
      # api_calls.today.group("DATE_FORMAT(api_calls.created_at, '%Y-%m-%d-%H')").count
      10
    end
    100
    # call_per_day_hash.empty? ? 0 : call_per_day_hash.values.last
  end

  def total_calls_limit_per_hour
    plans.active.sum(:calls_limit_per_hour) || 0
  end

  def requests_progress_bar
    if (total_requests_in_hour.present? && total_requests_in_hour != 0)
      percentage_usage = (total_requests_in_hour.to_f / total_calls_limit_per_hour.to_f) * 100
      percentage_usage.round(2)
    else
      0
    end
  end

  def last_thirty_days_calls
    if false
      api_calls.last_thirty_days.group("strftime('%Y-%m-%d', api_calls.created_at)").count
    else
      api_calls.last_thirty_days.group("DATE_FORMAT(api_calls.created_at, '%Y-%m-%d')").count
    end
  end

  private

    def log_recent_activity
      description = " has joined recently"
      self.create_recent_activity(description: description)
    end

end
