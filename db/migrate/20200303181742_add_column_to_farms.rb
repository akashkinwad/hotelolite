class AddColumnToFarms < ActiveRecord::Migration[5.2]
  def change
    add_column :farms, :map_iframe, :string
    add_column :farms, :is_featured, :boolean, default: false
    add_column :farms, :status, :integer, default: 0
  end
end
