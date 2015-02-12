class SimpleAuthController < ApplicationController
  set :method_override, true
  enable :sessions

  # console
  get '/console' do
    Pry.start(binding)
  end

  # Need a way to sign up
  get '/signup' do
    @employee = Employee.new

    erb :"/signup"
  end

  post '/signup' do
    @employee = Employee.new( name: params[:employee][:name] )

    if params[:employee][:password] == params[:employee][:password_confirmation]
      @employee.password = params[:employee][:password]

      if @employee.save
        login!(@employee)

        redirect to('/welcome')
      else
        erb :"/signup"
      end
    else
      @employee.errors.add(:password, "and confirmation need to match.")

      erb :"/signup"
    end
  end

  # Need a way to sign in

  get '/login' do
    @employee = Employee.new

    erb :"/login"
  end

  post '/login' do
    @employee = Employee.find_by_credentials(params[:employee])

    if @employee
      login!(@employee)

      redirect to('/welcome')
    else
      @employee = Employee.new(name: params[:employee][:name])

      @employee.errors.add(:password, "and name are not a valid combination.")
      erb :"/login"
    end
  end

  # Need a way to sign out

  delete '/logout' do
    logout!

    redirect to('/login')
  end

  # Need a way to check we're signed in

  get '/welcome' do
    @employee = current_employee

    erb :"/welcome"
  end

  private
  def create_token
    # this will provide us with a randomized string, and will be
    # used by current_user, and login!
    return SecureRandom.urlsafe_base64
  end

  def current_employee
    # if a user has authorization_token equal to the one stored in
    # session, they're our de facto current user
    Employee.find_by(authorization_token: session[:authorization_token])
  end

  def login!(employee)
    # this will be called when a user has authenticated.  it will need
    # to create an authorization_token, and set it for both the session
    # and the user

     employee.authorization_token = session[:authorization_token] = create_token

    employee.save
  end

  def logout!
    employee = current_employee

    employee.authorization_token = session[:authorization_token] = nil

    employee.save
  end
end