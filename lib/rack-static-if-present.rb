module Rack
  class StaticIfPresent
    def initialize(app, options={})
      @app = app
      options = options.dup
      @urls = options.delete(:urls) || ["/favicon.ico"]
      root = options.delete(:root)  || Dir.pwd
      new_options = options.inject({}) do |recased_opts, (k,v)|
        new_key = k.to_s.split("_").collect(&:capitalize).join("-")
        recased_opts[new_key] = v
        recased_opts
      end
      @file_server = Rack::File.new(root, new_options)
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
