Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension


get '/' do 

	@current_parties = Party.all 

	erb :index

end 




########## FOOD FOOD FOOD ##############




get '/foods' do
	
	@foods = Food.all 

	erb :"foods/index"

end 


get '/foods/new' do	

	erb :"foods/new"

end


post '/foods' do


	new_food = Food.create(params[:food])

	redirect to "/foods"

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




######## PARTY PARTY PARTY ##########




get '/parties' do 

	@current_parties = Party.all 

	erb :"parties/index"

end

get '/parties/new'	do 

# 	#Display a form for a new party

end

# post '/parties'	

# # Creates a new party

# end


get '/parties/:id' do 

	@party = Party.find(params[:id])

	@orders = Order.where(party_id: @party.id)

	erb :"parties/show"

end

#Display a single party, options for adding a food item to the party and closing the party.
# get	'/parties/:id/edit' do

# 	party = Party.all 

# 	erb :"parties/edit"
# 	#Display a form for to edit a party's details
# end

	
# patch '/parties/:id' do
# #Updates a party's details
# end


# delete	'/parties/:id' do	

# #Delete a party

# end

end

# POST	/orders	Creates a new order
# PATCH	/orders/:id	Change item to no-charge
# DELETE	/orders/:id	Removes an order
# GET	/parties/:id/receipt	Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
# PATCH	/parties/:id/checkout	Marks the party as paid