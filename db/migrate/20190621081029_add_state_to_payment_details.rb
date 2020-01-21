class AddStateToPaymentDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_details, :state, :string
  end
end
