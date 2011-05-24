module Rack
  module StaticIfPresent
    def initialize(app, options={})
      @app = app
      @urls = options[:urls] || ["/favicon.ico"]
      root = options[:root] || Dir.pwd
      @file_server = Rack::File.new(root)
    end

    def call(env)
      path = env["PATH_INFO"]
      can_serve = @urls.any? { |url| path.index(url) == 0 }

      if can_serve
        result = @file_server.call(env)
        return result if result[0] == 200
      end
      @app.call(env)
    end

  end
end
