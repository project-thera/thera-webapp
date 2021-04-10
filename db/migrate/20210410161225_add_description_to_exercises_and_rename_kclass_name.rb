class AddDescriptionToExercisesAndRenameKclassName < ActiveRecord::Migration[6.0]
  def change
    rename_column :exercises, :klass_name, :exercise_type
    add_column :exercises, :description, :string, after: :exercise_type
  end
end
