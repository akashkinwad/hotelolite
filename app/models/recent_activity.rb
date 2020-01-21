class RecentActivity < ApplicationRecord

  belongs_to :resource, polymorphic: true

  scope :todays, ->{ where("created_at >= ?", Date.today) }

  def css_class
    if resource_type == 'User'
      'kt-font-danger'
    elsif resource_type == 'Plan'
      'kt-font-primary'
    else
      'kt-font-success'
    end
  end

end
