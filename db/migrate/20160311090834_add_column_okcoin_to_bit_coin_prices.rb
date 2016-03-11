class AddColumnOkcoinToBitCoinPrices < ActiveRecord::Migration
  def change
  	add_column :app_configurations, :okcoin_api_key, :string
  	add_column :app_configurations, :okcoin_api_secret, :string
  end
end
