class Message
	#require 'rubygems' # not necessary with ruby 1.9 but included for completeness 
  #require 'twilio-ruby' 
  attr_accessor :account_sid, :auth_token, :client
  # put your own credentials here 
  def initialize(attributes={})
    @account_sid = Rails.application.secrets.twilio_account_id
    @auth_token = Rails.application.secrets.twilio_auth_token
  end
# set up a client to talk to the Twilio REST API 
  
  def sending_message(to, msg)
	  begin
		  @client = Twilio::REST::Client.new @account_sid, @auth_token
		  data = {
				:from => "+" + Rails.application.secrets.from_number.to_s, 
				:to => to,
				:body => msg,  
			}
			puts data.inspect
			@client.account.messages.create(data)
		rescue
      raise "Message not send"
		end
  end
end