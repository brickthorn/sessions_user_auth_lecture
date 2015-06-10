# STEP 1: Include `enable :sessions` in config/environment.rb and provide a session secret
# STEP 2: Profit

get '/' do
  session[:homepage_visited] = true
  "Welcome to the homepage! A cookie and session has been set!"
end

get '/test' do
  if session[:homepage_visited]
    return "Thanks for visiting again! <p> Here is the session hash: #{session.inspect} </p>"
  else
    return "Welcome! You may want to visit the <a href='/'>homepage</a> first. <p> Here is the session hash: #{session.inspect} </p>"
  end
end



# Where is the actual data in the session hash in Sinatra?  It's in the encrypted key:value pair!













# Using sessions to manage users
# Create a wireframes and/or flowcharts to keep things clear!

get '/login' do
  if session[user_id]
    redirect '/'
  else
    erb :'login'
  end
end


post '/session' do
  user = User.find_by(email: params[:email])    # we need a unique identifier for the user!
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = {login_error: "user name or password incorrect, try again"}
    erb :'login'
  end
end

get '/logout' do
  session[:user_id] = nil
end















# Customizing the Front Page

get '/' do
  if session[:user_id]
    user = User.find(session[:user_id])
    return "Hi #{user.email}"
  else
    session[:homepage_visited] = true
    "Welcome to the homepage! A cookie and session has been set!"
  end
end
























# Making your login page SMART!
# get '/login' do
#   if session[:user_id]
#     redirect '/'
#   else
#     erb :'login'
#   end
# end
