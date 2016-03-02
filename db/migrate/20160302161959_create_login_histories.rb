class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
    	t.references :user
    	t.string :ip_address
    	t.string :ip_location
    	t.string :user_agent
    	t.timestamps
    end
    add_column :users, :status, :string, default: 'unconfirmed'
  end
end
