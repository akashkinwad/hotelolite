class CreatePaymentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_details do |t|
      t.string :cashholders_name
      t.string :card_number
      t.string :expiry_date
      t.string :cvv
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :zipcode
      t.string :country
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
