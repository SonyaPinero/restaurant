class FoodsController < ApplicationController

	enable :sessions

	get '/' do
	
	@foods = Food.all 

	erb :"foods/index"

end 


get '/new' do	

	erb :"foods/new"

end


post '/' do


	@food = Food.new(params[:food])

	if @food.save 
		redirect to "/"
	else 
		erb :"foods/new"
	end

end


get '/:id' do 

	@food = Food.find(params[:id])

	@parties = @food.parties

	erb :"foods/show"

end 


get	'/:id/edit' do

	@food = Food.find(params[:id])

	erb :"foods/edit"

end


patch	'/:id' do 


	food = Food.find(params[:id])
  	
  food.update(
  		name: params[:food][:name], 
		cuisine: params[:food][:cuisine],
		allergens: params[:food][:allergens],
		price: params[:food][:price]
						)
	 
	 redirect to "/"

end


delete	'/:id'	do

	food = Food.find(params[:id])
  food.destroy

  redirect to '/'

end

end