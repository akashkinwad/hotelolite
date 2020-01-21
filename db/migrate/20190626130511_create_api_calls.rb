class CreateApiCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :api_calls do |t|
      t.references :user, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
