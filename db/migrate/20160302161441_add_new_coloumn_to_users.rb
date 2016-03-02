class AddNewColoumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :phone_number, :string
    add_column :users, :sms_verified, :boolean, default: false
    add_column :users, :id_verified, :boolean, default: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
