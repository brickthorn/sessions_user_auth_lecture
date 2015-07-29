
##Sessions and User Authorization

Download this repo and play around w/ sessions basics!

Most of the action is in `/controllers/index.rb`


### COMMON RESTful ROUTES FOR USERS

```ruby
#  for showing login and signup forms
get '/login'
get '/signup'
get '/logout'

# for creating a new user from the signup form:
post '/users/'

# for viewing an existing user
get '/users/5'

# for creating a new session after submit from the login form:
post '/sessions/'

# for logging out, (aka deleting a session)
delete '/session'
```

# Using bcrypt-ruby
Full documentation here:
https://github.com/codahale/bcrypt-ruby


## How to install bcrypt

    gem install bcrypt

The bcrypt gem is available on the following ruby platforms:

* JRuby
* RubyInstaller 1.8, 1.9, 2.0, and 2.1 builds on win32
* Any 1.8, 1.9, 2.0, 2.1, or 2.2 Ruby on a BSD/OS X/Linux system with a compiler


### The _User_ model

    require 'bcrypt'

    class User < ActiveRecord::Base
      # users.password_hash in the database is a :string
      include BCrypt

      def password
        @password ||= Password.new(password_hash)
      end

      def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
      end
    end

### Creating an account

    get '/users/new' do
      @user = User.new(params[:user])
      @user.password = params[:password]
      @user.save!
    end

### Authenticating a user

    get '/login' do
      @user = User.find_by_email(params[:email])
      if @user.password == params[:password]
        give_token        # eg set user_id in session!
      else
        redirect_to home_url
      end
    end

## How to use bcrypt-ruby in general

    require 'bcrypt'

    my_password = BCrypt::Password.create("my password")
      #=> "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"

    my_password.version              #=> "2a"
    my_password.cost                 #=> 10
    my_password == "my password"     #=> true
    my_password == "not my password" #=> false

    my_password = BCrypt::Password.new("$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa")
    my_password == "my password"     #=> true
    my_password == "not my password" #=> false

Check the rdocs for more details -- BCrypt, BCrypt::Password.


* Author  :: Coda Hale <coda.hale@gmail.com>
* Website :: http://blog.codahale.com
