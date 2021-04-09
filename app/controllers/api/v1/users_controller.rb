class Api::V1::UsersController < Api::V1::BaseController
  memberable_api_actions actions: [:discard, :undiscard, :stop_supervision]
  memberable_api_actions_with_context actions: [:start_supervision]

  def current
    jsonapi_render json: current_user
  end
end