class AddUsageToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :usage, :integer, default: 0
  end
end
