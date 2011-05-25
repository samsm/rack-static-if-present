require 'bundler'
Bundler::GemHelper.install_tasks

desc "Run all the fast tests"
task :test do
  opts     = ENV['TEST'] || '-a'
  specopts = ENV['TESTOPTS'] ||
    "-q -t '^(?!Rack::Adapter|Rack::Session::Memcache|Rack::Server)'"

  sh "bacon -I./lib:./test -w #{opts} #{specopts}"
end
