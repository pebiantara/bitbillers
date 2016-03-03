class LoginHistory < ActiveRecord::Base
  belongs_to :user

  def extract_location
    JSON.parse(ip_location)
  end

  def complete_name
    [
    	extract_location["city_name"],
      extract_location["region_name"],
    	extract_location["postal_code"],
      extract_location["country_name"],
      extract_location["country_code2"]
    ].join(", ") rescue '-'
  end

  def agent_name
		if self.user_agent
			user_agent = UserAgent.parse(self.user_agent)
			[user_agent.browser, "version: " + user_agent.version.to_s, user_agent.platform].join(" - ")
		else
      "-"
		end
  end
end