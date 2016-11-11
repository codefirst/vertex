module Vertex
  class Line
    def initialize(token)
      @access_token = token
    end

    def notify(message)
      return if @access_token.blank?
      uri = URI.parse('https://notify-api.line.me/api/notify')
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri.request_uri)
      req['Authorization'] = "Bearer #{@access_token}"
      req.set_form_data(message: message)
      https.request(req)
    end
  end
end
