class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :config_devise_params, if: :devise_controller?

  private

  def private_controller?
    return false if controller_path == 'home'

    true
  end

  def layout_by_resource
    if devise_controller?
      'session'
    elsif private_controller? then 'private'
    else 'application'
    end
  end

  protected

  def config_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[
                                        first_name
                                        last_name
                                        username
                                        email
                                        password
                                        password_confirmation
                                      ])
  end
end
