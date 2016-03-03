module ApplicationHelper

	def flash_messages
		message = notice || alert
		return if message.nil?
		alert_class = if notice.present? 
			'alert-success'
		elsif alert.present?
			'alert-danger'
		end
		content_tag :div, class: "alert #{alert_class}" do
			button_tag(class: 'close', data:{dismisss: 'alert'}, aria: {label: 'Close'}) do
        content_tag :span, aria: {hidden: "true"}
			end
			notice || alert
		end
	end

	def user_get_status(user)
    if user.status.eql?('unconfirmed')
      "label label-warning"
    elsif user.status.eql?('locked')
      "label label-danger"
    else
      "label label-success"         
    end	
	end

	def get_trade_status(status)
    if status.eql?('trade_open')
      "label label-info"
    elsif status.eql?('trade_expired')
      "label label-danger"
    elsif status.eql?('btc_sent')
      "label label-success"
    elsif status.eql?('buying_btc')
      "label label-warning"
    else
      "label label-default"    	
    end
	end
end
