class Api::V1::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token, only: [:create]

  respond_to :json

  def respond_with(resource, opts = {})
    if resource.errors.present?
      render json: { errors: resource.errors }
    else
      render json: resource
    end
  end
end