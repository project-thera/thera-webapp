module Admin
  class BaseController < ApplicationController
    layout 'admin'

    # before_action :redirect_to_sign_in, unless: :user_signed_in?

    before_action :authenticate_user!

    def index
      @current_user = current_user
      
      render html: nil, layout: true
    end
  
    private
  
    # def recognize_referrer_path
    #   Rails.application.routes.recognize_path request.referrer
    # end
  
    def user_removes_own_administrador_sistema_group?
      referrer = recognize_referrer_path
  
      referrer[:controller] == 'admin/users' && referrer[:action] == 'edit' && !current_user.administrador_sistema?
    end
  
    def user_not_authorized
      # FIXME: Find a better way to handle this.
      # This prevents redirection loop, see https://proyectos.slyt.gba.gov.ar/issues/12763
      if user_removes_own_administrador_sistema_group?
        redirect_to root_path
      else
        flash[:alert] = t('pundit.not_authorized')
        redirect_to(request.referrer || root_path)
      end
    end
  
    def redirect_to_sign_in
      store_action
      redirect_to new_user_session_path
    end
  
    # Uncomment this only if you are working from home!
    # def user_logged_in?
    #   Rails.env.development? ? true : super
    # end
  
    # def current_user
    #   Rails.env.development? ? User.find_by(username: 'lucio.digiacomo') : super
    # end
  
    # Store referrer path to redirect after sign in.
    # See https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out
    def store_action
      return unless request.get?
  
      path_black_list = %w(/users/sign_in /users/sign_up /users/password/new /users/password/edit /users/confirmation /users/sign_out)
  
      #store_location_for(:devise_cas_referrer, request.fullpath) if !request.xhr? && path_black_list.exclude?(request.path)
      session[:devise_cas_referrer] = request.fullpath if !request.xhr? && path_black_list.exclude?(request.path)
    end
  end
end