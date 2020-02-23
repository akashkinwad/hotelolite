class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :name
      t.references :farm, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
