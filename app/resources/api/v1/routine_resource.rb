class Api::V1::RoutineResource < Api::V1::BaseResource
  attributes :name,
    :daily_limit,
    :created_at,
    :updated_at
  
  attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  has_one :patient
  has_one :supervisor

  has_many :exercises
  has_many :routine_exercises
  has_many :routine_intents

  attributes :supervisor_id, :patient_id, format: :id

  accepts_nested_attributes_for_has_many :routine_exercises, Api::V1::RoutineExerciseResource

  filter :discarded, apply: ->(records, value, _options) {
    if ActiveModel::Type::Boolean.new.cast(value[0])
      records.discarded
    else
      records.kept
    end
  }
end