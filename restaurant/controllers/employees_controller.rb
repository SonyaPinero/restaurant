class EmployeesController < ApplicationController

	enable :sessions

get '/' do

	@employees = Employee.all

	erb :"employees/index"

end 


get '/login' do

	@employees = Employee.all

	erb :"employees/login"

end 


post '/login' do

	employee_id = params[:employee][:id]

	session[:employee_id] = params[:employee][:id]

	redirect to "/#{employee_id}" 

end


get '/:id' do

	session[:employee_id] = params[:id]

	@employee = Employee.find(params[:id])

	@parties = @employee.parties

	erb :"employees/show"

end


end 