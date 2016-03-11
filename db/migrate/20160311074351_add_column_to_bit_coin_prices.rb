class AddColumnToBitCoinPrices < ActiveRecord::Migration
  def change
  	add_column :bit_coin_prices, :bitfinex, :decimal, precision: 8, scale: 2, default: 0
  	add_column :bit_coin_prices, :okcoin, :decimal, precision: 8, scale: 2, default: 0
  	add_column :bit_coin_prices, :itbit, :decimal, precision: 8, scale: 2, default: 0
  	add_column :bit_coin_prices, :bitstamp, :decimal, precision: 8, scale: 2, default: 0
  	add_column :bit_coin_prices, :coinbase, :decimal, precision: 8, scale: 2, default: 0
  end
end
