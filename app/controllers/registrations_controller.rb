class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name)
  end

  def after_sign_up_path_for(resource)
    dashboard_path
  end
end