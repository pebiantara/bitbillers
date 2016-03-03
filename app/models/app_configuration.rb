class AppConfiguration < ActiveRecord::Base

  def self.current_config
  	self.last
  end
end