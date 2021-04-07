class Api::V1::UserResource < Api::V1::BaseResource
  attributes :username,
    :fullname,
    :email,
    :last_sign_in_at,
    :last_sign_in_ip,
    :created_at,
    :updated_at
  
  # attribute :discarded, delegate: :discarded?
  # attribute :group_ids, format: :ids

  # ransack_filters :username_cont

  has_many :groups

  filter :patients, apply: ->(records, value, _options) {
    if ActiveModel::Type::Boolean.new.cast(value[0])
      return records.patients
    end

    records
    
  }
end