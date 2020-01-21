class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.boolean :has_trial
      t.datetime :start_time
      t.datetime :end_time
      t.string :s_type
      t.boolean :active
      t.boolean :auto_renewal, default: false
      t.references :user, foreign_key: true, type: :bigint
      t.references :plan, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
