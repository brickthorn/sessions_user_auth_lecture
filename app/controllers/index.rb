# STEP 1: Include `enable :sessions` in config/environment.rb and provide a session secret
# NOTE: the session hash is just like the params hash or the response object. they are created
# by rack!  the sessions hash is created when the browser presents it's session cookie.
# STEP 2: Read or write the the session hash as needed.

get '/' do
  session[:user_name] = "Number 6"
  "Welcome to the homepage! A session cookie has set your name!"
end

get '/test' do
  if session[:user_name]
    return "Thanks for visiting again! You are: #{session[:user_name]}
    <p> Here is the whole session hash: #{session.inspect} </p>"
  else
    return "Welcome! You may want to visit the <a href='/'>homepage</a> first. <p> Here is the session hash: #{session.inspect} </p>"
  end
end


# Can we make the homepage more dynamic and let it display your name if you have visited already?














# Using sessions to manage users
# Create a wireframes and/or flowcharts to keep things clear!

get '/login' do
  if session[:user_id]
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


# Now, shouldn't the homepage be a bit different if we're logged in!?!?



# COMMON RESTful ROUTES FOR USERS

# #  for showing login and signup forms
# get '/login'
# get '/signup'
# get '/logout'

# # for creating a new user from the signup form:
# post '/users/'

# # for viewing an existing user
# get '/users/5'

# # for creating a new session after submit from the login form:
# post '/sessions/'

# # for logging out, (aka deleting a session)
# delete '/session'













# Customizing the Front Page

# get '/' do
#   if session[:user_id]
#     user = User.find(session[:user_id])
#     return "Hi #{user.email}"
#   else
#     session[:homepage_visited] = true
#     "Welcome to the homepage! A cookie and session has been set!"
#   end
# end




# What about encrypting the password!?!?!
# use Bcrypt for now!
# https://gist.github.com/brickthorn/e5886bea49ae3e05d118


