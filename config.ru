require 'rubygems'
require 'bundler'
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

$stdout.sync = true
require './quick_tunes'

# see: http://thepugautomatic.com/2012/07/sinatra-with-rack-cache-on-heroku/
# Defined in ENV on Heroku. To try locally, start memcached and uncomment:
# ENV["MEMCACHE_SERVERS"] = "localhost"
if memcache_servers = ENV["MEMCACHE_SERVERS"]
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_servers}/meta",
    entitystore: "memcached://#{memcache_servers}/body"
end

run QuickTunes
