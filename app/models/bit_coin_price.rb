class BitCoinPrice < ActiveRecord::Base

  def self.new_price
    last.price.to_f.scale_2
  end
end