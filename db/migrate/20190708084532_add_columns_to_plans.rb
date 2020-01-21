class AddColumnsToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :is_available_monthly, :boolean
    add_column :plans, :is_available_annually, :boolean
    add_column :plans, :free_trial_days, :integer
  end
end
