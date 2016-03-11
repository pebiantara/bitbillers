require 'bitfinex/bitfinex'
class Market
  attr_accessor :bitfinex_api_key, :bitfinex_api_secret
  
  def initialize(attribs={})
    @bitfinex_api_key = AppConfiguration.current_config.bitfinex_api_key
    @bitfinex_api_secret = AppConfiguration.current_config.bitfinex_api_secret
  end

  def get_bitfinex_price
    bfx = Bitfinex.new
    ticker = bfx.ticker
    ticker[:ask]
  end

  def markets
    {
    	bitfinex: get_bitfinex_price,
    	okcoin: 0,
    	coinbase: 0,
    	bitstamp: 0,
    	itbit: 0
    }
  end
end