require 'rack/proxy'

# https://numb86-tech.hatenablog.com/entry/2019/01/10/211416
class AssetsPathProxy < Rack::Proxy

  def perform_request(env)
    if env['PATH_INFO'].include?("/images/")
      if Rails.env != 'production'
        dev_server = env['HTTP_HOST'].gsub(':3000', ':3035')
        env['HTTP_HOST'] = dev_server
        env['HTTP_X_FORWARDED_HOST'] = dev_server
        env['HTTP_X_FORWARDED_SERVER'] = dev_server
      end
      env['PATH_INFO'] = "/packs/images/" + env['PATH_INFO'].split("/").last
      super
    else
      @app.call(env)
    end
  end

end
