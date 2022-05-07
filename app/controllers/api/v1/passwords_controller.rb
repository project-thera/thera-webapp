class Api::V1::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token, only: [:create]

  respond_to :json

  def respond_with(resource, opts = {})
    if opts[:location].present?
      render json: resource
    else
      render json: { errors: resource.errors }
    end
  end
end