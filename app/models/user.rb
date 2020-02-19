class User < ApplicationRecord
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one :farm
  has_many :bookings, through: :farm

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

  scope :joined, ->(date){ where("created_at >= ?", date) }

  after_create :create_farm
  after_create :log_recent_activity

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

  private

    def create_farm
      self.create_farm!
    end

    def log_recent_activity
      description = " has joined recently"
      self.create_recent_activity(description: description)
    end

end
