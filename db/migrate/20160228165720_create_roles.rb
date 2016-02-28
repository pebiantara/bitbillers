class CreateRoles < ActiveRecord::Migration
  def change
  	create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_table :users_roles do |t|
      t.references :user
      t.references :role
      t.timestamps
    end
  end
end
