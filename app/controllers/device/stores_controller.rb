class Device::StoresController < ApplicationController
	before_action :define_store
	before_action :checking_store_authentication, only: [:verify, :verifying, :charge, :charging]

	def show
		reset_session
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
				trade.update_attributes status: 'buying_btc', location_to_pay: @store.name
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
    if session[:user_buying].nil? || session[:trade_id].nil?
      redirect_to buy_device_store_path and return
    end
	end

	def storing
		authenticate = @store.authenticate(params[:screen_id])
		if authenticate
			session[:store_authenticate] = true
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
			reset_session
			redirect_to device_store_path, notice: "Trading has been completed."
		end
	end

	private
	def checking_store_authentication
		unless session[:store_authenticate].eql?(true)
			redirect_to device_store_path, notice: 'Need to store authenticated' and return
		end
	end

	def reset_session
		session[:user_buying] = nil
		session[:trade_id] = nil
		session[:store_authenticate] = nil
	end

	def define_store
		@store = Store.friendly.find(params[:id])
	end
end