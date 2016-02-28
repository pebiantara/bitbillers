class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :selected_layout
  before_action :authorize

  def selected_layout
    params[:controller].include?('admin') ? 'admin' : 'application'
  end

  def authorize
    if current_user && !current_user.is_admin?
      redirect_to :root_path, alert: 'You dont have authorization.'
    end
  end
end
