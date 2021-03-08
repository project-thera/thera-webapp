class CreateRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :routines do |t|
      t.belongs_to :supervisor, foreign_key: { to_table: :users }, null: false
      t.belongs_to :patient, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
