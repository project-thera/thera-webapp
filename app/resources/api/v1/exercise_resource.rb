class Api::V1::ExerciseResource < Api::V1::BaseResource
  attributes :name,
    :description,
    :exercise_type,
    :steps,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
end