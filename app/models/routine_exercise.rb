class RoutineExercise < ApplicationRecord
  belongs_to :routine, required: true
  belongs_to :exercise, required: true

  scope :supervised_by, -> (user) {
    joins(:routine).where(routines: { supervisor: user })
  }

  scope :owned_by, -> (user) {
    joins(:routine).where(routines: { patient: user })
  }
end
