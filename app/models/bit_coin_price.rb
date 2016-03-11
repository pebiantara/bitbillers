class BitCoinPrice < ActiveRecord::Base

  def self.new_price
    last.price.to_f.scale_2
  end

  def self.current_price
    last
  end

  def self.pricing
    [current_price.bitfinex, current_price.okcoin, current_price.coinbase, current_price.itbit, current_price.bitstamp].max
  end

  def self.pricing_with_fee
    self.pricing + self.pricing * AppConfiguration.current_config.fee_percent/100
  end

  def self.prices_json
  	cur = current_price
    { 
    	maxprice: pricing,
    	price: pricing_with_fee.to_f.scale_2, 
    	bitfinex: cur.bitfinex,
    	okcoin: cur.okcoin, 
    	itbit: cur.itbit, 
    	bitstamp: cur.bitstamp, 
    	coinbase: cur.coinbase, 
    	updated_at: cur.updated_at.strftime("%Y-%m-%d at %H:%M:%S %Z")
    }
  end
end