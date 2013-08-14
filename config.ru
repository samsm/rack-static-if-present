require 'rubygems'
require 'rack'
require './lib/rack-static-if-present'

class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Apparently no static file here."]]
  end
end

# Run in this directory, the files in this project should get served (for example: http://localhost:9292/Rakefile).
use Rack::StaticIfPresent, :urls => ['/']

run HelloWorld.new
