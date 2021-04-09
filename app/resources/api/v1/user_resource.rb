class Api::V1::UserResource < Api::V1::BaseResource
  attributes :username,
    :fullname,
    :email,
    :last_sign_in_at,
    :last_sign_in_ip,
    :supervisor_id,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  ransack_filters :username_cont

  has_many :groups
  has_many :supervised_routines
  has_many :routines

  has_one :supervisor

  filter :patients, apply: ->(records, value, _options) {
    if ActiveModel::Type::Boolean.new.cast(value[0])
      return records.patients
    end

    records
    
  }
end