require 'rubygems'
require 'bundler'

Bundler.require

require './quick_tunes'

require 'rack/reloader'
use Rack::Reloader, 0 if development?

run Sinatra::Application
