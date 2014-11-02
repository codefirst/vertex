module Vertex
  class AsakusaSatellite
    def initialize
      @url     = ENV['ASAKUSA_SATELLITE_URL']
      @room    = ENV['ASAKUSA_SATELLITE_ROOM']
      @api_key = ENV['ASAKUSA_SATELLITE_API_KEY']
    end

    def notify(message)
      if @url == nil or @room == nil or @api_key == nil
        puts message
        return
      end
      uri = URI.parse("#{@url}/api/v1")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = uri.scheme == 'https'
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.start do |conn|
        conn.post(uri.path + "/message", URI.encode_www_form({
          room_id: @room,
          api_key: @api_key,
          message: message
        }))
      end
    end
  end
end
