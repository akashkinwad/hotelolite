class AddColumnsToFarm < ActiveRecord::Migration[5.2]
  def change
    add_column :farms, :facebook_url, :string
    add_column :farms, :instagram_url, :string
    add_column :farms, :whatsapp_no, :string
  end
end
