class Trade < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :usd_amount, :btc_amount, :phone_number, :wallet
  validates_numericality_of :usd_amount, :btc_amount
  
  validate :checking_minimum_and_maximum
  validate :checking_daily_deposit

  scope :today, -> {where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))	}
  scope :trade_open, -> {where(status: 'trade_open')}
  scope :trade_expired, -> {where(status: 'trade_expired')}
  scope :withdraw_requested, -> {where(status: 'withdraw_requested')}
  scope :btc_sent, -> {where(status: 'btc_sent')}
  scope :buying_btc, -> {where(status: 'buying_btc')}

  attr_accessor :update_status

  def checking_minimum_and_maximum
    return if update_status
    if self.usd_amount.to_f < AppConfiguration.current_config.minimum_deposit
      self.errors.add(:usd_amount, "Minimum deposit is $#{AppConfiguration.current_config.minimum_deposit}")
    elsif self.usd_amount.to_f > AppConfiguration.current_config.maximum_deposit
      self.errors.add(:usd_amount, "Maximum deposit is $#{AppConfiguration.current_config.maximum_deposit}")    	
    end
  end

  def checking_daily_deposit
    return if update_status
    daily = self.user.trades.today.sum(:usd_amount)
    if daily > AppConfiguration.current_config.maximum_daily_deposit
      self.errors.add(:daily_deposit, "Maximum daily deposit is $#{AppConfiguration.current_config.maximum_daily_deposit}")
    elsif (daily + usd_amount.to_f) > AppConfiguration.current_config.maximum_daily_deposit
      self.errors.add(:daily_deposit, "Today only have $#{AppConfiguration.current_config.maximum_daily_deposit - daily}")
    end
  end

  def self.states
    {
    	trade_open: "Trade Open",
    	trade_expired: "Trade Expired",
    	withdraw_requested: "Withdraw Requested",
    	btc_sent: "BTC sent",
    	buying_btc: "Buying BTC"
    }
  end
end