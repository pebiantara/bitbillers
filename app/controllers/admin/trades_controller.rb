class Admin::TradesController < Admin::ApplicationController

  def index

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

  private
  def trade_params
    params.require(:trade).permit(:usd_amount, :btc_amount, :phone_number, :wallet, :user_id, :username, :email)
  end
end