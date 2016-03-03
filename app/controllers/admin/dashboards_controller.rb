class Admin::DashboardsController < Admin::ApplicationController

  def index
    @trades = Trade.withdraw_requested.order(created_at: :desc).page(params[:page]).per(25)
  end
end