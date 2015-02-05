require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
 adapter: :postgresql,
 database: :restaurant,
 host: :localhost,
 port: 5432
)

Create some heroes
[
  {
    cuisine: "Tex-Mex",
    name: "Chimichanga",
    allergens: "gluten",
    price: 7
  },
  {
    cuisine: "Tex-Mex",
    name: "Chile Con Carne",
    allergens: "gluten",
    price: 5
  },
  {
    cuisine: "Tex-Mex",
    name: "Beef Tacos",
    allergens: "gluten",
    price: 6
  }
].each do |food|
  Food.create( food )
end

# Create some parties
[
  {
    table_number: 1,
    guests: 2,
    paid: false
  },
{
    table_number: 3,
    guests: 2,
    paid: true
}
].each do |party|
  Party.create( party )
end

# Create some armor
[
  {
    food_id: 9,
    party_id: 4
},
  {
    food_id: 10,
    party_id: 4
},
{
    food_id: 11,
    party_id: 5
},
{
    food_id: 10,
    party_id: 5
}
].each do |order|
  Order.create( order )
end