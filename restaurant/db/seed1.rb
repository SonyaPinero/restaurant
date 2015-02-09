require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

db=PG.connect( dbname: 'restaurant')

init_foods = <<-SQL
    CREATE TABLE foods(
        id SERIAL PRIMARY KEY,
        cuisine text NOT NULL,
        name text NOT NULL,
        price int NOT NULL,
        allergens text,
        created_at TIMESTAMP CURRENT_TIMESTAMP,
        updated_at TIMESTAMP CURRENT_TIMESTAMP
        )
        SQL

init_orders = <<-SQL
    CREATE TABLE orders(
        id SERIAL PRIMARY KEY,
        food_id INT,
        party_id INT,
        created_at TIMESTAMP CURRENT_TIMESTAMP,
        updated_at TIMESTAMP CURRENT_TIMESTAMP
        )
        SQL

init_parties = <<-SQL
    CREATE TABLE parties(
        id SERIAL PRIMARY KEY,
        table_number INT NOT NULL,
        guests INT NOT NULL,
        paid BOOLEAN DEFAULT false,
        tip INT,
        employee_id INT,
        created_at TIMESTAMP CURRENT_TIMESTAMP,
        updated_at TIMESTAMP CURRENT_TIMESTAMP
        )
        SQL

init_employees = <<-SQL
    CREATE TABLE employees(
        id SERIAL PRIMARY KEY,
        name text NOT NULL,
        created_at TIMESTAMP CURRENT_TIMESTAMP,
        updated_at TIMESTAMP CURRENT_TIMESTAMP
        )
        SQL

#Create some heroes
[
  {
    cuisine: 'Tex-Mex',
    name: 'Chimichanga',
    allergens: 'Gluten',
    price: 7
  },
  {
    cuisine: 'Tex-Mex',
    name: 'Chile Con Carne',
    allergens: 'Gluten',
    price: 5
  },
  {
    cuisine: 'Tex-Mex',
    name: 'Beef Tacos',
    allergens: 'Gluten',
    price: 6
  },
  {
    cuisine: 'Tex-Mex',
    name: 'Enchiladas',
    allergens: 'Lactose',
    price: 5
  },
  {
    cuisine: 'Tex-Mex',
    name: 'Fajitas',
    allergens: 'Gluten',
    price: 7
  },
  {
    cuisine: 'Tex-Mex',
    name: 'Quesadilla',
    allergens: 'Lactose',
    price: 5
  }
].each do |food|
  Food.create( food )
end

# Create some parties
[
  {
    table_number: 4,
    guests: 2,
    paid: false,
    tip: 15,
    employee_id: 1
  },
{
    table_number: 3,
    guests: 2,
    paid: false,
    tip: 0,
    employee_id: 3
},
{
  table_number: 2,
    guests: 2,
    paid: false,
    tip: 0,
    employee_id: 2
},
{
  table_number: 1,
    guests: 2,
    paid: true,
    tip: 15,
    employee_id: 1
  },
{
  table_number: 5,
    guests: 2,
    paid: false,
    tip: 0,
    employee_id: 2
    },
{
  table_number: 6,
    guests: 2,
    paid: true,
    tip: 20,
    employee_id: 1
}
].each do |party|
  Party.create( party )
end

# Create some orders
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
},
{
    food_id: 11,
    party_id: 5
},
{
    food_id: 9,
    party_id: 7
},
{
    food_id: 11,
    party_id: 7
},
{
    food_id: 11,
    party_id: 8
},
{
    food_id: 14,
    party_id: 8
},
{
    food_id: 14,
    party_id: 11
},
{
    food_id: 18,
    party_id: 11
}
].each do |order|
  Order.create( order )
end

[
{
  name: 'Maria'
},
{
  name: 'Jose'
},
{
  name: 'Juan'
},
{
  name: 'Paco'
}
].each do |employee|
  Employee.create( employee )
end


db.exec("DROP TABLE IF EXISTS foods")
db.exec("DROP TABLE IF EXISTS orders")
db.exec("DROP TABLE IF EXISTS parties")
db.exec("DROP TABLE IF EXISTS employees")

db.exec(init_foods)
db.exec(init_orders)
db.exec(init_parties)
db.exec(init_employees)