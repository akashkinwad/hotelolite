class CreateFarmCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :farm_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :farm, null: false, foreign_key: true
    end
  end
end
