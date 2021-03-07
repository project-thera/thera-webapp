class Api::V1::GroupsController < Api::V1::BaseController
  memberable_api_actions actions: [:discard, :undiscard]
end