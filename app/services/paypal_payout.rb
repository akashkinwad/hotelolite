class PaypalPayout
  attr_accessor :plan, :return_url, :cancel_url, :amount

  def initialize(options = {})
    self.plan = options[:plan]
    self.return_url = options[:return_url]
    self.cancel_url = options[:cancel_url]
    self.amount = options[:amount]
  end

  def send_paypal_request
    PayPal::SDK::REST::Payment.new(payout_params)
  end

  private

  def payout_params
    {
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: return_url,
        cancel_url: cancel_url },
      transactions: [{
        item_list: {
          items: [{
            name: "Plan",
            sku: plan.name,
            price: amount,
            currency: "INR",
            quantity: 1
          }]
        },
        amount: {
          total: amount,
          currency: "INR"
        },
        description: "Dynamic Plan API Payment"
      }]
    }
  end
end
