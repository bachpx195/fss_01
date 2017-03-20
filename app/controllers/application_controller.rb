class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_ransack_object
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def set_ransack_object
    @q = Recipe.ransack params[:q]
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end

  def user_not_authorized
    flash[:error] = t "notification.not_authorized"
    redirect_to request.referrer || root_path
  end

  def after_sign_in_path_for resource
    if resource.role == "admin"
      admin_root_path
    else
      request.env['omniauth.origin'] || root_path
    end
  end
end
