class CreateSubSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_sections do |t|
      t.string :title
      t.string :description
      t.references :section, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
