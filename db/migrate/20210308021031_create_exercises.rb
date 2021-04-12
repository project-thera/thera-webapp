class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.string :exercise_type, null: false
      t.string :description
      t.text :steps

      t.timestamps null: false
    end
  end
end
