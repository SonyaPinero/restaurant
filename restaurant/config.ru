require_relative 'environment'

#\ -p 3000

# Make sure we load all the gems
require 'bundler'
Bundler.require :default

# Then connect to the database
set :database, {
  adapter: "postgresql", database: "restaurant",
  host: "localhost", port: 5432
}

map('/employees') { run EmployeesController }
map('/foods') { run FoodsController }
map('/orders') { run OrdersController }
map('/parties') { run PartiesController }
map('/receipts') { run ReceiptsController }
map('/') { run SimpleAuthController }


run Sinatra::Application

require './app'
run Restaurant