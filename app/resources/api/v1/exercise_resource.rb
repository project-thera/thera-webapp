class Api::V1::ExerciseResource < Api::V1::BaseResource
  attributes :name,
    :klass_name,
    :steps,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
end