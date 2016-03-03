class Trade < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :usd_amount, :btc_amount, :phone_number, :wallet
  validates_numericality_of :usd_amount, :btc_amount
  
  validate :checking_minimum_and_maximum
  validate :checking_daily_deposit

  scope :today, -> {where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))	}

  def checking_minimum_and_maximum
    if self.usd_amount.to_f < AppConfiguration.current_config.minimum_deposit
      self.errors.add(:usd_amount, "Minimum deposit is $#{AppConfiguration.current_config.minimum_deposit}")
    elsif self.usd_amount.to_f > AppConfiguration.current_config.maximum_deposit
      self.errors.add(:usd_amount, "Maximum deposit is $#{AppConfiguration.current_config.maximum_deposit}")    	
    end
  end

  def checking_daily_deposit
    daily = self.user.trades.today.sum(:usd_amount)
    if daily > AppConfiguration.current_config.maximum_daily_deposit
      self.errors.add(:daily_deposit, "Maximum daily deposit is $#{AppConfiguration.current_config.maximum_daily_deposit}")
    elsif (daily + usd_amount.to_f) > AppConfiguration.current_config.maximum_daily_deposit
      self.errors.add(:daily_deposit, "Today only have $#{AppConfiguration.current_config.maximum_daily_deposit - daily}")
    end
  end
end