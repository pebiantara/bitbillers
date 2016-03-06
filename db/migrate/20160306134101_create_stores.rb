class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
    	t.string     :name
    	t.string     :encrypted_password
    	t.string     :address
    	t.string     :city
    	t.string     :phone_number
    	t.string     :zipcode
    	t.string     :slug
    	t.timestamps
    end
  end
end