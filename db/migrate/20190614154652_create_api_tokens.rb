class CreateApiTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :api_tokens do |t|
      t.string :name
      t.string :token
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
    add_index :api_tokens, :token, unique: true
  end
end
