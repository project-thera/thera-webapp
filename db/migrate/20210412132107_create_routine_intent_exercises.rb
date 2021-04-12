class CreateRoutineIntentExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_intent_exercises do |t|
      t.belongs_to :routine_intent
      t.belongs_to :exercise

      t.integer :status, limit: 1, default: 1, comment: "skipped: 0, completed: 1"
    end
  end
end
