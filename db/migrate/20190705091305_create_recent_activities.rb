class CreateRecentActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :recent_activities do |t|
      t.string :description
      t.integer :resource_id
      t.string :resource_type

      t.timestamps
    end
    add_index :recent_activities, :resource_id
    add_index :recent_activities, :resource_type
  end
end
