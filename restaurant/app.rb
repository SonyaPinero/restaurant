Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension

enable :sessions 

get '/console' do 
	Pry.start(binding)

end

get '/' do 
	@current_parties = Party.where(paid: false) 
	erb :index
end 


end



