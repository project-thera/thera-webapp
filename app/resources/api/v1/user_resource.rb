class Api::V1::UserResource < Api::V1::BaseResource
  attributes :username,
    :fullname,
    :email,
    :last_sign_in_at,
    :last_sign_in_ip,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
  attribute :group_ids, format: :ids
  attribute :supervisor_id, format: :id


  ransack_filters :username_cont, :username_or_email_or_fullname_cont

  has_many :groups
  has_many :supervised_routines
  has_many :routines
  has_many :routine_intents

  has_one :supervisor
  has_one :game_reward

  filter :patients, apply: ->(records, value, _options) {
    if ActiveModel::Type::Boolean.new.cast(value[0])
      return records.patients
    end

    records
  }

  filter :own_patients,
    verify: ->(values, context) {
      if ActiveModel::Type::Boolean.new.cast(values[0])
        return context[:user]
      end

      return nil
    },
    apply: ->(records, value, _options) {
      unless value == nil
        return records.where(supervisor: value)
      end

      records
    }

end