class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :provider_tournament_id
      t.integer :status, default: 0
      t.references :provider, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
