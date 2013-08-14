# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack-static-if-present/version"

Gem::Specification.new do |s|
  s.name        = "rack-static-if-present"
  s.version     = Rack::Static::If::Present::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sam Schenkman-Moore"]
  s.email       = ["samsm@samsm.com"]
  s.homepage    = "http://github.com/samsm/rack-static-if-present"
  s.summary     = %q{Like Rack::Static. Except only if there is a static file to serve.}
  s.description = %q{Not much to explain. Not a lot of code, but wanted it packaged up for easy use/deployment.}

  s.rubyforge_project = "rack-static-if-present"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license = 'MIT'

  s.add_dependency 'rack', ['> 1']

  s.add_development_dependency 'bacon'
end
