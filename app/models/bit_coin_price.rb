class BitCoinPrice < ActiveRecord::Base

  def self.new_price
    last.price
  end
end