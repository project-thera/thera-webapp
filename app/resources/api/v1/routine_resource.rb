class Api::V1::RoutineResource < Api::V1::BaseResource
  attributes :created_at,
    :updated_at
  
  attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  # ransack_filters :username_cont
  has_one :patient
  has_one :supervisor

  has_many :exercises
  has_many :routine_exercises

  attributes :supervisor_id, :patient_id

  accepts_nested_attributes_for_has_many :routine_exercises, Api::V1::RoutineExerciseResource

  filter :discarded, apply: ->(records, value, _options) {
    if ActiveModel::Type::Boolean.new.cast(value[0])
      records.discarded
    else
      records.kept
    end
  }
end