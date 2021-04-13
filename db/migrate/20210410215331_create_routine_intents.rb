class CreateRoutineIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_intents do |t|
      t.belongs_to :routine, null: false
      t.datetime :started_at, null: false
      t.datetime :finished_at, null: true

      t.timestamps null: false
    end
  end
end
