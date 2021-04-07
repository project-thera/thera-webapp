class Api::V1::RoutineResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  # ransack_filters :username_cont
  has_one :patient
  has_one :supervisor

  has_many :exercises
end