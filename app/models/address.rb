class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :address, :city, :zip_code, :state, :country
end