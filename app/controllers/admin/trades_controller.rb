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
    @trade = Trade.new(trade_params)
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

  private
  def trade_params
    params.require(:trade).permit(:usd_amount, :btc_amount, :phone_number, :wallet, :user_id, :username, :email)
  end
end