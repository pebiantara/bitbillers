require 'bitfinex/bitfinex'
class Market
  attr_accessor :bitfinex_api_key, :bitfinex_api_secret, :okcoin_api_key, :okcoin_api_secret
  
  def initialize(attribs={})
    @bitfinex_api_key = AppConfiguration.current_config.bitfinex_api_key
    @bitfinex_api_secret = AppConfiguration.current_config.bitfinex_api_secret
    @okcoin_api_key = AppConfiguration.current_config.okcoin_api_key
    @okcoin_api_secret = AppConfiguration.current_config.okcoin_api_secret
  end

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

  def markets
    {
    	bitfinex: get_bitfinex_price,
    	okcoin: get_okcoin_price,
    	coinbase: 0,
    	bitstamp: 0,
    	itbit: 0
    }
  end
end