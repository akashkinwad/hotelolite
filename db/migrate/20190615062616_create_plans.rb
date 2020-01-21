class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.text :features
      t.decimal :price_per_month
      t.decimal :price_per_year
      t.integer :calls_limit_per_hour
      t.boolean :active
      t.integer :sports_type

      t.timestamps
    end
  end
end
