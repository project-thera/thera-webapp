class Api::V1::RoutineIntentResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at,
    :routine_id,
    :finished_at,
    :data

  has_one :routine

  ransack_filters :finished_at_lteq, :finished_at_gteq
end