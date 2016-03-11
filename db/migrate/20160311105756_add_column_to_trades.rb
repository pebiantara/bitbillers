class AddColumnToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :exchange_rate, :decimal, precision: 8, scale: 2, default: 0
  end
end
