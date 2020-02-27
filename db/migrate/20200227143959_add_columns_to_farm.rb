class AddColumnsToFarm < ActiveRecord::Migration[5.2]
  def change
    add_column :farms, :facebook_url, :string
    add_column :farms, :instagram_url, :string
    add_column :farms, :whatsapp_no, :string
    add_column :farms, :address, :string
    add_column :farms, :no_of_rooms, :string
    add_column :farms, :area, :string
    add_column :farms, :food_type, :string
    add_column :farms, :time_to_visit, :string
    add_column :farms, :email, :string
    add_column :farms, :owner_name, :string
  end
end
