class AddConstToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :const, :string
    add_index :categories, :const, unique: true
  end
end
