class CreateRoutineExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_exercises do |t|
      t.belongs_to :routine, null: false
      t.belongs_to :exercise, null: false

      t.integer :repetitions, default: 1

      t.timestamps null: false
    end
  end
end
