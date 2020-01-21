class PaymentDetail < ApplicationRecord

  serialize :expiry_date, Hash
  belongs_to :user

  validates :cashholders_name,presence: true, length: { minimum: 2 }
  validates :card_number,presence: true, length: { is: 16 }
  validates :expiry_date, presence: true
  validates :cvv,presence: true, length: { is: 3 }
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, length: { is: 6 }
  validates :country, presence: true
end
