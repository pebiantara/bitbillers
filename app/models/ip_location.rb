class IpLocation
  def self.lookup(ip_address)
    loc = GeoIP.new("#{Rails.root}/lib/GeoLiteCity.dat")
    loc.city(ip_address)
  end
end