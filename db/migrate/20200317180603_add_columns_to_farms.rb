class AddColumnsToFarms < ActiveRecord::Migration[5.2]
  def change
    add_column :farms, :stars, :integer
    add_column :farms, :reviews, :integer
  end
end
