class Plan < ApplicationRecord
  enum sports_type: [ :cricket, :football, :tennis ]
  enum usage: [ :external, :internal ]

  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_one :recent_activity, as: :resource
  has_and_belongs_to_many :tournaments
  has_many :matches, through: :tournaments

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :calls_limit_per_hour,
            :sports_type,
            presence: true
  validates :sports_type, inclusion: { in: sports_types.keys }
  validates :usage, inclusion: { in: usages.keys }

  validates :price_per_month,
            presence: true,
            unless: Proc.new { |plan| plan.is_available_monthly.blank? }
  validates :price_per_year,
            presence: true,
            unless: Proc.new { |plan| plan.is_available_annually.blank? }
  validate :presence_of_price_per_monthly_or_yearly

  after_create :log_recent_activity

  scope :active, -> { where(active: true) }
  scope :available_monthly, ->{
    where(
      'price_per_month IS NOT ? AND price_per_month != ? AND is_available_monthly is ?',
      nil, '', true
    )
  }
  scope :available_annually, ->{
    where(
      'price_per_year IS NOT ? AND price_per_year != ? AND is_available_annually is ?',
      nil, '', true
    )
  }

  def subscription_css_icon
    if id.even?
      "flaticon-confetti"
    elsif false
      "flaticon-piggy-bank"
    elsif false
      "flaticon-gift"
    else
      "flaticon-rocket"
    end
  end

  private

    def log_recent_activity
      description = "Plan #{name} has been created"
      self.create_recent_activity(description: description)
    end

    def presence_of_price_per_monthly_or_yearly
      if %w(is_available_monthly is_available_annually).all?{|attr| self[attr].blank?}
        errors.add(:base, 'Please select monthly or yearly availability.')
      end
    end

end
