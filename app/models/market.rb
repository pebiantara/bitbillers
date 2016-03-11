require 'bitfinex/bitfinex'
require 'coinbase/wallet'
class Market
  attr_accessor :bitfinex_api_key, :bitfinex_api_secret, :okcoin_api_key, :okcoin_api_secret
  
  def initialize(attribs={})
    @bitfinex_api_key = AppConfiguration.current_config.bitfinex_api_key
    @bitfinex_api_secret = AppConfiguration.current_config.bitfinex_api_secret
    @okcoin_api_key = AppConfiguration.current_config.okcoin_api_key
    @okcoin_api_secret = AppConfiguration.current_config.okcoin_api_secret
    @coinbase_api_key = AppConfiguration.current_config.coinbase_api_key
    @coinbase_api_secret = AppConfiguration.current_config.coinbase_api_secret  end

  def get_bitfinex_price
  	begin
	    bfx = Bitfinex.new(@bitfinex_api_key, @bitfinex_api_secret)
	    ticker = bfx.ticker
	    ticker[:ask]
	  rescue
      0
	  end
  end

  def get_okcoin_price
  	begin
  	  okcoin = Okcoin::Rest.new api_key: @okcoin_api_key, secret_key: @okcoin_api_secret
  	  ticker = okcoin.spot_ticker(pair: "btc_usd")
  	  ticker["ticker"]["sell"].to_f
	  rescue
      0
	  end
  end

  def get_coinbase_price
    begin
      client = Coinbase::Wallet::Client.new(api_key: @coinbase_api_key, api_secret: @coinbase_api_secret)
      #[client.sell_price(currency: "USD"), client.buy_price(currency: "USD"), client.spot_price(currency: "USD")]
      client.spot_price(currency: "USD")["amount"]
    rescue
      0
    end
  end

  def markets
    {
    	bitfinex: get_bitfinex_price,
    	okcoin: get_okcoin_price,
    	coinbase: get_coinbase_price,
    	bitstamp: 0,
    	itbit: 0
    }
  end
end