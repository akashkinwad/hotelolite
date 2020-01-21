class AddAllowAllTournamentsToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :allow_all_tournaments, :boolean, default: false
  end
end
