class Api::V1::RoutineExerciseResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at,
    :repetitions
  
  # attribute :discarded, delegate: :discarded?
  attribute :routine_id
  attribute :exercise_id

  has_one :routine
  has_one :exercise

  def to_nested_attribute
    {
      id: _model.id,
      routine_id: _model.routine_id,
      exercise_id: _model.exercise_id,
    }
  end
end