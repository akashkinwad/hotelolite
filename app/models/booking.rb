class Booking < ApplicationRecord

  validates :first_name,
            :last_name,
            :email,
            :contact_no,
            :check_in,
            presence: true
  validate :check_in_cannot_be_in_the_past

  belongs_to :farm

  private

  def check_in_cannot_be_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "can't be in the past")
    end
  end
end
