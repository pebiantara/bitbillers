class Configurations < ActiveRecord::Migration
  def change
  	create_table :app_configurations do |t|
      t.float :fee_percent, default: 2
      t.float :maximum_daily_deposit, default: 1000
      t.float :maximum_deposit, default: 1000
      t.float :minimum_deposit, default: 100
      t.float :id_requirement, default: 1000
      t.timestamps
  	end
  end
end
