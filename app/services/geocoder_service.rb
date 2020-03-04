class GeocoderService
  attr_accessor :ip

  def initialize(options = {})
    self.ip = options[:ip]
  end

  def location
    request = Geocoder.search(ip)
    request[0].data['loc']
  end

  def formatted_lat_lng
    splitted = location.split(',')
    { lat: splitted[0]&.to_f, lng: splitted[1]&.to_f }
  end
end