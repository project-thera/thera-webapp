class Api::V1::RoutineIntentResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at,
    :routine_id,
    :finished_at

  has_one :routine
  has_many :routine_intent_exercises

  ransack_filters :finished_at_lteq, :finished_at_gteq
end