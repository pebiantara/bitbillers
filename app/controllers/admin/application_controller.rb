class Admin::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :authorize

  def authorize
    if current_user && !current_user.is_admin?
      redirect_to root_path, alert: 'You dont have authorization.'
    end
  end
end