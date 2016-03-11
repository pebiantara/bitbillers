class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :selected_layout
  helper_method :set_login_history, :prices_json
  before_action :market_price

  def selected_layout
    if params[:controller].include?('admin') 
      'admin'
    elsif params[:controller].include?('device')
      'device/device'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    set_login_history(current_user)
    if current_user.is_admin?
      admin_root_path
    else
      session[:return_to].present? ? sesion[:return_to] : root_path
    end
  end

  def set_login_history(user=nil)
    ip_addr = Rails.env.eql?('development') ? '104.236.38.53' : request.remote_ip
    location = IpLocation.lookup(ip_addr)
    if user
      history = user.login_histories.build(ip_address: ip_addr, ip_location: location.to_json, user_agent: request.env['HTTP_USER_AGENT'])
      history.save
    end
  end

  def market_price
    m = Market.new
    prices = m.markets
    BitCoinPrice.current_price.update_attributes(prices)
  end

  def prices_json
    BitCoinPrice.prices_json
  end
end