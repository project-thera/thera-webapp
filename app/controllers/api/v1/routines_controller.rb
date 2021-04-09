class Api::V1::RoutinesController < Api::V1::BaseController
  memberable_api_actions actions: [:discard, :undiscard]
end