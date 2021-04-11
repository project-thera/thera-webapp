class CreateRoutineIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_intents do |t|
      t.belongs_to :routine, null: false
      t.datetime :finished_at
      t.text :data

      t.timestamps null: false
    end
  end
end
