class CreateBooking < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_no
      t.string :altr_contact_no
      t.string :email, null: false, default: ""
      t.datetime :check_in
      t.references :farm, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
