class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :configure_permitted_parameters

  respond_to :json
  
  def build_resource(hash = {})
    super(hash)

    self.resource.add_patient_group
  end

  def respond_with(resource, opts = {})
    if resource.errors.present?
      render json: { errors: resource.errors } # Triggers the appropriate serializer
    else
      render json: resource
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :fullname, :password, :password_confirmation])
  end
end