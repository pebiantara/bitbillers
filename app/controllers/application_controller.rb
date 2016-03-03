class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :selected_layout
  helper_method :set_login_history

  def selected_layout
    params[:controller].include?('admin') ? 'admin' : 'application'
  end

  def after_sign_in_path_for(resource_or_scope)
    set_login_history
    if current_user.is_admin?
      admin_root_path
    else
      session[:return_to].present? ? sesion[:return_to] : root_path
    end
  end

  def set_login_history
    ip_addr = Rails.env.eql?('development') ? '104.236.38.53' : request.remote_ip
    location = IpLocation.lookup(ip_addr)
    if current_user
      history = current_user.login_histories.build(ip_address: ip_addr, ip_location: location.to_json, user_agent: request.env['HTTP_USER_AGENT'])
      history.save
    end
  end
end