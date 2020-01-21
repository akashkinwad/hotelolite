class Setting < ApplicationRecord

  validates :key,
            :value,
            presence: true

  def self.free_trial_days
    free_trial_days = Setting.where(key: "free_trial_days").collect(&:value).first rescue 0
    free_trial_days.present? ? free_trial_days.to_i : 0
  end

end
