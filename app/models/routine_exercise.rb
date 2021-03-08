class RoutineExercise < ApplicationRecord
  belongs_to :routine, required: true
  belongs_to :exercise, required: true
end
