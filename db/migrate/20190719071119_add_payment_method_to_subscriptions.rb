class AddPaymentMethodToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :payment_method, :string
    add_column :subscriptions, :stripe_email, :string
    add_column :subscriptions, :stripe_token, :string
  end
end
