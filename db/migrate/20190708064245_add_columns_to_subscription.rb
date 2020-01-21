class AddColumnsToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :price_per_month, :decimal
    add_column :subscriptions, :price_per_year, :decimal
    add_column :subscriptions, :calls_limit_per_hour, :decimal
    add_column :subscriptions, :sports_type, :string
  end
end
