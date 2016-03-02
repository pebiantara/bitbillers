class CreateTradesAndBitCoinPrices < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :user
      t.decimal :usd_amount, precision: 8, scale: 2, default: 0
      t.decimal :btc_amount, precision: 8, scale: 2, default: 0
      t.string  :phone_number
      t.string  :wallet
      t.string  :username
      t.string  :email
      t.string  :status, default: 'trade_open'
      t.string  :location_to_pay
      t.timestamps
    end

    create_table :bit_coin_prices do |t|
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.timestamps
    end
  end
end