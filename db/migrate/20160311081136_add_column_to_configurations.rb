class AddColumnToConfigurations < ActiveRecord::Migration
  def change
  	add_column :app_configurations, :bitfinex_api_key, :string
  	add_column :app_configurations, :bitfinex_api_secret, :string  	
  end
end
