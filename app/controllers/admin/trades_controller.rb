class Admin::TradesController < Admin::ApplicationController

  def index
    @trades = Trade.order(created_at: :desc)
    if params[:status].present?
      @trades = @trades.where(status: params[:status])
    end
    @trades = @trades.page(params[:page]).per(25)
  end

  def new
    @bitcoin_price = BitCoinPrice.new_price
    @trade = Trade.new
  end

  def create
    @bitcoin_price = BitCoinPrice.new_price
    phone_number = trade_params[:phone_number]
    user = User.find_or_initialize_by(phone_number: phone_number)
    user.email = trade_params[:email]
    user.username = trade_params[:username]
    user.save(validate: false)
    
    @trade = Trade.new(trade_params.merge(user_id: user.id))
    if @trade.save
      redirect_to new_admin_trade_path, notice: 'Trade successfully created, you can manage on trade menu'
    else
      render :new
    end
  end

  def release
    @trade = Trade.find_by_id(params[:id])
  end

  def released
    @trade = Trade.find_by_id(params[:id])
    @updated = @trade.update_attributes(status: 'btc_sent', update_status: true)
  end
  def status
    @trade = Trade.find_by_id(params[:id])
  end

  def change_status
    @trade = Trade.find_by_id(params[:id])
    @state = @trade.update_attributes(status: params[:trade][:status], update_status: true)
  end

  private
  def trade_params
    params[:trade][:phone_number] = params[:trade][:phone_number].gsub(")", '').gsub("(","").gsub("-",'') rescue ""
    params.require(:trade).permit(:usd_amount, :btc_amount, :phone_number, :wallet, :user_id, :username, :email)
  end
end