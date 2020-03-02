class AddSlugToFarms < ActiveRecord::Migration[5.2]
  def change
    add_column :farms, :slug, :string
    add_index :farms, :slug, unique: true
  end
end
