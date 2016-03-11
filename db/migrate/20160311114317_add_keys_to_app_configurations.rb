class AddKeysToAppConfigurations < ActiveRecord::Migration
  def change
  	add_column :app_configurations, :itbit_client_key, :string
  	add_column :app_configurations, :itbit_secret_key, :string
  	add_column :app_configurations, :itbit_user_id, :string
  	add_column :app_configurations, :bitstamp_api_key, :string
  	add_column :app_configurations, :bitstamp_api_secret, :string
  	add_column :app_configurations, :bitstamp_client_id, :string
  end
end
