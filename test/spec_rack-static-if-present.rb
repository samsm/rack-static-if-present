require File.expand_path(File.dirname(__FILE__)) + '/../lib/rack-static-if-present'
require 'rack/mock'
require 'ruby-debug'
class DummyApp
  def call(env)
    [200, {}, ["Hello World"]]
  end
end

describe Rack::StaticIfPresent do
  root = File.expand_path(File.dirname(__FILE__))

  OPTIONS = {:urls => ["/cgi"], :root => root}
  HASH_OPTIONS = {:urls => {"/cgi/sekret" => 'cgi/test'}, :root => root}

  @request = Rack::MockRequest.new(Rack::StaticIfPresent.new(DummyApp.new, OPTIONS))
  @hash_request = Rack::MockRequest.new(Rack::StaticIfPresent.new(DummyApp.new, HASH_OPTIONS))

  it "serves files" do
    res = @request.get("/cgi/test")
    res.should.be.ok
    res.body.should =~ /ruby/
  end

  # This is the part that is different than Rack:Static
  #  Rack::Static's spec:
  # it "404s if url root is known but it can't find the file" do
  it "calls down the chain if url root is known but it can't find the file" do
    res = @request.get("/cgi/foo")
    # res.should.be.not_found
    res.body.should == "Hello World"
  end

  it "calls down the chain if url root is not known" do
    res = @request.get("/something/else")
    res.should.be.ok
    res.body.should == "Hello World"
  end

  it "serves hidden files" do
    res = @hash_request.get("/cgi/sekret")
    res.should.be.ok
    res.body.should =~ /ruby/
  end

  it "calls down the chain if the URI is not specified" do
    res = @hash_request.get("/something/else")
    res.should.be.ok
    res.body.should == "Hello World"
  end

  it "supports serving fixed cache-control" do
    opts = OPTIONS.merge(:cache_control => 'public')
    request = Rack::MockRequest.new(Rack::StaticIfPresent.new(DummyApp.new, opts))
    res = request.get("/cgi/test")
    res.should.be.ok
    res.headers['Cache-Control'].should == 'public'
  end

end
