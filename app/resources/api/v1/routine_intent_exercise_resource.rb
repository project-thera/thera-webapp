class Api::V1::RoutineIntentExerciseResource < Api::V1::BaseResource
  attributes :status

  has_one :routine_intent
  has_one :exercise
end