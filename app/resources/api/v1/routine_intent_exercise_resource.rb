class Api::V1::RoutineIntentExerciseResource < Api::V1::BaseResource
  attributes :status, :exercise_id

  has_one :routine_intent
  has_one :exercise

  def to_nested_attribute
    {
      id: _model.id,
      exercise_id: _model.exercise_id,
      status: _model.status,
    }
  end
end