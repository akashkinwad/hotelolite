class AddResourceToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :resource_id, :integer
    add_column :subscriptions, :resource_type, :string
    add_index :subscriptions, :resource_id
    add_index :subscriptions, :resource_type
  end
end