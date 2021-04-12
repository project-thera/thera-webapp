class CreateRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :routines do |t|
      t.belongs_to :supervisor, foreign_key: { to_table: :users }, null: false
      t.belongs_to :patient, foreign_key: { to_table: :users }, null: false
      t.integer :daily_limit, limit: 1, default: 1

      t.timestamps null: false

      t.datetime :discarded_at
    end
  end
end
