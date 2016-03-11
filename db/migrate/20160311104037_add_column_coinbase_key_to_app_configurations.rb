class AddColumnCoinbaseKeyToAppConfigurations < ActiveRecord::Migration
  def change
  	add_column :app_configurations, :coinbase_api_key, :string
  	add_column :app_configurations, :coinbase_api_secret, :string
  end
end
