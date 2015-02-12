require 'rubygems'
require 'bundler'

if ENV['APP_ENV'] == 'development'
  require 'sinatra/reloader'
  Bundler.require(:default, :development)
  ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    dbname: 'restuarant',
    host: 'localhost', port: 5432
  })
else
  Bundler.require(:default)
  ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    dbname: 'restuarant'
  })
end

['models/concerns', 'models', 'helpers', 'controllers'].each do |component|
  Dir["#{component}/*.rb"].sort.each do |file|
    require File.expand_path(file)
  end
end