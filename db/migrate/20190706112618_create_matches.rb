class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :title
      t.integer :provider_id
      t.references :tournament, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
