class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :response
      t.string :info
      t.references :user, foreign_key: true, type: :bigint
      t.references :subscription, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
