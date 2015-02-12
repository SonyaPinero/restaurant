class PartiesController < ApplicationController

	enable :sessions

get '/' do 

	@current_parties = Party.all 

	erb :"parties/index"

end


get '/new'	do 

	erb :"parties/new"

end


post '/'	do

	params[:party][:employee_id] = session[:employee_id] 

	@new_party = Party.create(params[:party])

	redirect to '/'

end


get '/:id' do 

	session[:party_id] = params[:id]

	@party = Party.find(params[:id])

	@order = Order.where(party_id: @party.id).first

	erb :"parties/show"

end


get	'/:id/edit' do

	@party = Party.find(params[:id])

	erb :"parties/edit"

end

	
patch '/:id' do

	party = Party.find(params[:id])
  	
  	party.update(
  		table_number: params[:party][:table_number], 
			guests: params[:party][:guests],
			paid: params[:party][:paid]
						)

	redirect to "/#{party.id}"

end


delete	'/:id' do	

	party = Party.find(params[:id])
  	party.destroy

  redirect to '/'

end


get '/:id/receipt' do 

	@party = Party.find(params[:id])

	@foods = @party.foods

	@total = @foods.sum(:price)

	erb :"parties/receipt"

end

patch '/:id/checkout' do 
	party = Party.find(params[:id])
	party.update(params[:party])

	redirect to '/'
end 

end