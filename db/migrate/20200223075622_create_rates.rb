class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :title
      t.decimal :amount
      t.references :farm, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
