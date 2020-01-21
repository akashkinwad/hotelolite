class ApiCall < ApplicationRecord
  belongs_to :user

  scope :today, ->{ where("created_at >= ?", Date.today) }
  scope :this_hour, ->{ where("created_at >= ?", Time.now.hour) }
  scope :last_thirty_days, ->{ where("created_at >= ?", (Date.today - 30.days)) }

end
