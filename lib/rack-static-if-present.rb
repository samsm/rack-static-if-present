module Rack
  class StaticIfPresent
    def initialize(app, options={})
      @app = app
      @urls = options[:urls] || ["/favicon.ico"]
      root = options[:root] || Dir.pwd
      cache_control = options[:cache_control]
      @file_server = Rack::File.new(root, cache_control)
    end

    def call(env)
      path = env["PATH_INFO"]

      unless @urls.kind_of? Hash
        can_serve = @urls.any? { |url| path.index(url) == 0 }
      else
        can_serve = @urls.key? path
      end

      if can_serve
        env["PATH_INFO"] = @urls[path] if @urls.kind_of? Hash
        file = @file_server.call(env)
        return file if file[0] == 200
      end
      @app.call(env)
    end
  end
end
