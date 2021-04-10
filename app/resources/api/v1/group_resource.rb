class Api::V1::GroupResource < Api::V1::BaseResource
  attributes :name,
    :created_at,
    :updated_at,
    :discarded_at

  filters :name
  ransack_filters :name_cont
end