class CreateJoinTablePlansTournaments < ActiveRecord::Migration[5.2]
  def change
    create_join_table :plans, :tournaments do |t|
      t.index [:plan_id, :tournament_id]
      t.index [:tournament_id, :plan_id]
    end
  end
end
