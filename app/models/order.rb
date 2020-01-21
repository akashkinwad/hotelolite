class Order < ApplicationRecord
  serialize :response, JSON
  serialize :info, JSON

  belongs_to :subscription, required: false
  belongs_to :user

  def details
    PayPal::SDK::REST::Payment.find(response['paymentId'])
  end
end
