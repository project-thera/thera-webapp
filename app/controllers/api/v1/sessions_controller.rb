class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]
  after_action :set_csrf_headers, only: :create

  # # POST /resource/sign_in
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      sign_in(user, resource)

      render json: { email: user.email }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  protected
    def set_csrf_headers
      # if request.xhr?
        # Add the newly created csrf token to the page headers
        # These values are sent on 1 request only
        response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
        response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
      # end
    end
end