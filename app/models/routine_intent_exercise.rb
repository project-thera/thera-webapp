class RoutineIntentExercise < ApplicationRecord
  enum status: { skipped: 0, completed: 1 }
  belongs_to :routine_intent, required: true
  belongs_to :exercise, required: true

  scope :supervised_by, -> (user) {
    joins(routine_intent: :routine).where(routine_intents: { routines: { supervisor: user } })
  }

  scope :owned_by, -> (user) {
    joins(routine_intent: :routine).where(routine_intents: { routines: { patient: user } })
  }
end
