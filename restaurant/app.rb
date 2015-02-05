Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension


get '/' do 

	@current_parties = Party.all 

	erb :index

end 


get '/foods' do
	
	@foods = Food.all 

	erb :"foods/index"

end 


get '/foods/new' do	

	erb :"foods/form"

end


post '/foods' do


	new_food = Food.create(params[:food])

	redirect to ("foods/#{new_food.id}")

end


get '/foods/:id' do 

	@food = Food.find(params[:id])

	@parties = @food.parties

	erb :"foods/show"

end 


get	'/foods/:id/edit' do

	@food = Food.find(params[:id])

	erb :"foods/edit"

end


patch	'/foods/:id' do 


	food = Food.find(params[:id])
  	
  food.update(
  		name: params[:food][:name], 
		cuisine: params[:food][:cuisine],
		allergens: params[:food][:allergens],
		price: params[:food][:price]
						)
	 
	 redirect to "/foods"

end


delete	'/foods/:id'	do

	food = Food.find(params[:id])
  food.destroy

  redirect to '/foods'

end



end


# GET	/parties	Display a list of all parties
# GET	/parties/:id	Display a single party, options for adding a food item to the party and closing the party.
# GET	/parties/new	Display a form for a new party
# POST	/parties	Creates a new party
# GET	/parties/:id/edit	Display a form for to edit a party's details
# PATCH	/parties/:id	Updates a party's details
# DELETE	/parties/:id	Delete a party
# POST	/orders	Creates a new order
# PATCH	/orders/:id	Change item to no-charge
# DELETE	/orders/:id	Removes an order
# GET	/parties/:id/receipt	Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
# PATCH	/parties/:id/checkout	Marks the party as paid