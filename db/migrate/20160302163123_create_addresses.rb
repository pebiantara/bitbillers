class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.references :user
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.timestamps
    end
  end
end
