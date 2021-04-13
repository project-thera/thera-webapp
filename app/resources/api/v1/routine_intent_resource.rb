class Api::V1::RoutineIntentResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at,
    :routine_id,
    :started_at,
    :finished_at

  has_one :routine
  has_many :routine_intent_exercises

  ransack_filters :started_at_lteq, :started_at_gteq
end