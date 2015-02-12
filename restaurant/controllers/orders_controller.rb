class OrdersController < ApplicationController

	enable :sessions 

get '/new' do 

	party_id = session[:party_id]

	@foods = Food.all

	@party = Party.find(party_id)

	# @parties = Party.all

	erb :"order/new"

end


post '/' do 

	food_id = params[:food][:id]
	party_id = params[:party][:id]

	new_order = Order.create(
		food_id: food_id,
		party_id: party_id
				)

	redirect to "/../parties/#{party_id}" 

end


get '/:id/edit' do 

	@order_id = params[:id]

	order = Order.find_by(id: params[:id])

	party_id = order.party_id 

	@party_foods = Party.find(party_id).foods
	@table_number = Party.find(party_id).table_number

	erb :"order/edit"

end 


patch '/:id' do

	food_id = params[:food][:id]

	old_order = Order.find_by(id: params[:id])

	party_id = old_order.party_id

	new_order = old_order.update(
		food_id: food_id,
		party_id: party_id
				)

redirect to "/../parties/#{party_id}" 

end


delete '/:id' do 

	old_order = Order.find(params[:id])

	party_id = old_order.party_id

	old_order.destroy 

	redirect to "/../parties/#{party_id}"  

end

end