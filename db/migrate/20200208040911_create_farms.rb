class CreateFarms < ActiveRecord::Migration[5.2]
  def change
    create_table :farms do |t|
      t.string :title
      t.text :description
      t.string :contact_no
      t.string :altr_contact_no
      t.string :district
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
