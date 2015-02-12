class ReceiptsController < ApplicationController

	enable :sessions 


get '/' do

	@parties = Party.where(paid:true)

	erb :"receipts/show"

end

end