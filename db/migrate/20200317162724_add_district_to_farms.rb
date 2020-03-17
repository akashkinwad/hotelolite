class AddDistrictToFarms < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :farms, :district
      remove_column :farms, :district
    end
    add_reference :farms, :district, index: true, foreign_key: true, type: :bigint
  end
end
