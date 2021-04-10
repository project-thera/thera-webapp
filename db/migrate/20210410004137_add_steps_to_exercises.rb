class AddStepsToExercises < ActiveRecord::Migration[6.0]
  def change
    add_column :exercises, :steps, :text, after: :klass_name
  end
end
