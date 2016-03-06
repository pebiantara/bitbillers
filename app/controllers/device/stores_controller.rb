class Device::StoresController < ApplicationController
  before_action :define_store

  def show
  	session[:user_buying] = nil
    session[:trade_id] = nil
  end

  def buy
  end

  def buying
  	user = User.find_by_phone_number(params[:screen_id])
  	if user.present?
  		set_login_history(user)
  		session[:user_buying] = user.id
  		trade = user.trades.open_or_buying.first
  		if trade
  			trade.update_attributes status: 'buying_btc'
    		session[:trade_id] = trade.id
        redirect_to store_device_store_path(@store)
      else
    		flash.now[:error] = "You have not trading for now."
        render :buy
    	end

  	else
  		flash.now[:error] = "User not found"
      render :buy
  	end
  end

  def store

  end

  def storing
    authenticate = @store.authenticate(params[:screen_id])
    if authenticate
      redirect_to verify_device_store_path
    else
  		flash.now[:error] = "Store password invalid"
      render :store
    end
  end

  def verify  	
    @user = User.find_by_id(session[:user_buying])
  end

  def verifying
    @trade = Trade.find_by_id(session[:trade_id])
    if @trade
      redirect_to charge_device_store_path(@store)
    else
    	flash[:error] = "Trading not found"
    	render :verifying
    end
  end

  def charge
    @trade = Trade.find_by_id(session[:trade_id])
  end

  def charging
    @trade = Trade.find_by_id(session[:trade_id])
    @updated = @trade.update_attributes(status: 'withdraw_requested') if @trade
    if @updated
    	session[:user_buying] = nil
    	session[:trade_id] = nil
      redirect_to device_store_path, notice: "Trading has been completed."
    end
  end

  private
  def define_store
    @store = Store.friendly.find(params[:id])
  end
end