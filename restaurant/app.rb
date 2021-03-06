Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension

enable :sessions 


get '/' do 

	@current_parties = Party.where(paid: false) 

erb :index

end 




########## WORK WORK WORK ##############




get '/employees' do

	@employees = Employee.all

	erb :"employees/index"

end 



get '/employees/login' do

	@employees = Employee.all

	erb :"employees/login"

end 


post '/employees/login' do

	employee_id = params[:employee][:id]

	session[:employee_id] = params[:employee][:id]

	redirect to "/employees/#{employee_id}" 

end


get '/employees/:id' do

	session[:employee_id] = params[:id]

	@employee = Employee.find(params[:id])

	@parties = @employee.parties

	erb :"employees/show"

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


	@food = Food.new(params[:food])

	if @food.save 
		redirect to "/foods"
	else 
		erb :"foods/new"
	end

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

	erb :"parties/new"

end


post '/parties'	do

	params[:party][:employee_id] = session[:employee_id] 

	@new_party = Party.create(params[:party])

	redirect to '/parties'

end


get '/parties/:id' do 

	session[:party_id] = params[:id]

	@party = Party.find(params[:id])

	@order = Order.where(party_id: @party.id).first

	erb :"parties/show"

end


get	'/parties/:id/edit' do

	@party = Party.find(params[:id])

	erb :"parties/edit"

end

	
patch '/parties/:id' do

	party = Party.find(params[:id])
  	
  	party.update(
  		table_number: params[:party][:table_number], 
			guests: params[:party][:guests],
			paid: params[:party][:paid]
						)

	redirect to "/parties/#{party.id}"

end


delete	'/parties/:id' do	

	party = Party.find(params[:id])
  	party.destroy

  redirect to '/parties'

end


get '/parties/:id/receipt' do 

	@party = Party.find(params[:id])

	@foods = @party.foods

	@total = @foods.sum(:price)

	erb :"parties/receipt"

end


# get '/parties/:id/checkout' do

# 	session[:party_tip] = params[:party][:tip]

# 	@party = Party.find(params[:id])

# 	erb :"parties/checkout"

# end


patch '/parties/:id/checkout' do 
	party = Party.find(params[:id])
	party.update(params[:party])

	redirect to '/parties'
end 




######## ORDER ORDER ORDER ##########




get '/orders/new' do 

	party_id = session[:party_id]

	@foods = Food.all

	@party = Party.find(party_id)

	# @parties = Party.all

	erb :"order/new"

end


post '/orders' do 

	food_id = params[:food][:id]
	party_id = params[:party][:id]

	new_order = Order.create(
		food_id: food_id,
		party_id: party_id
				)

	redirect to "/parties/#{party_id}" 

end


get '/orders/:id/edit' do 

	@order_id = params[:id]

	order = Order.find_by(id: params[:id])

	party_id = order.party_id 

	@party_foods = Party.find(party_id).foods
	@table_number = Party.find(party_id).table_number

	erb :"order/edit"

end 


patch '/orders/:id' do

	food_id = params[:food][:id]

	old_order = Order.find_by(id: params[:id])

	party_id = old_order.party_id

	new_order = old_order.update(
		food_id: food_id,
		party_id: party_id
				)

redirect to "/parties/#{party_id}" 

end


delete '/orders/:id' do 

	old_order = Order.find(params[:id])

	party_id = old_order.party_id

	old_order.destroy 

	redirect to "/parties/#{party_id}" 

end


get '/receipts' do

	@parties = Party.where(paid:true)

	erb :"receipts/show"

end


get '/console' do 
	Pry.start(binding)
end







end



