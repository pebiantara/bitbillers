class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :selected_layout

  def selected_layout
    params[:controller].include?('admin') ? 'admin' : 'application'
  end
end
