class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: true
      t.string :klass_name, null: true

      t.timestamps
    end
  end
end
