class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:new, :create]
  after_action :set_csrf_headers, only: :create

  skip_before_action :require_no_authentication, only: [:new, :create]

  respond_to :json

  def resource_name
    :user
  end

  def respond_with(resource, opts = {})
    if resource.id.present?
      render json: resource
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }
    end
  end

  # # POST /resource/sign_in
  # def create
  #   puts "create"
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   puts resource_name
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end

  # def create
  #   user = User.find_by_email(sign_in_params[:email])

  #   if user && user.valid_password?(sign_in_params[:password])
  #     sign_in(user, resource)

  #     render json: resource
  #   else
  #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message! :notice, :signed_out if signed_out
  #   yield if block_given?
  #   respond_to_on_destroy
  # end

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