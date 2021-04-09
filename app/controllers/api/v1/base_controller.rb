class Api::V1::BaseController < ApiController
  include JSONAPI::Utils
  include MemberableApiActions
  include MemberableApiActionsWithContext
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  #before_action :set_userstamp

  rescue_from ActiveRecord::RecordNotFound, with: :jsonapi_render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    errors = [{
      title: 'No tiene permisos para realizar esta acción',
      detail: 'No tiene permisos para realizar esta acción',
      code: 'FORBIDDEN_ERROR',
      source: { pointer: '/data/attributes/base'}
    }]

    jsonapi_render_errors json: errors, status: :forbidden
  end

  def context
    { user: current_user }
  end

  # def set_userstamp
  #   RequestStore.store[:userstamp] = current_user.try(:id)
  # end 
end