class Api::V1::ExerciseResource < Api::V1::BaseResource
  attributes :name,
    :klass_name,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  # ransack_filters :username_cont
end