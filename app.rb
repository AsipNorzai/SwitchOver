require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg' #to connect postgress
require 'postageapp'

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'

#################### sessions enabler to used in current_user method #######################
enable :sessions

########################### helpers methods for checking login and link creation ############
helpers do

  def link(label, href)
    "<a href='#{ href }'>#{label}</a>"
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def able_edit?(post_id, post_email)
    # posts = Post.all
    # posts.each do |post|
      post_id == current_user.id || post_email == current_user.email
    # end
  end

  def logged_in?
    !!current_user
  end

  PostageApp.configure do |config|
  config.api_key = '6CdcEWLcgKORh5p9Lceff7KkEFlIy3Ox'
  end

end

################## closes the connection between DB and ActiveRecord ####################
after do
  ActiveRecord::Base.connection.close
end

################## shows all the posts currently in the DB #########################
get '/' do
  @post = Post.all
  erb :index
end

############## goes to the new page where form is located for creating a new post###########
get '/posts/new' do
  redirect to '/login' unless logged_in?
  erb :new
end

######################creates a new post when /posts/new is visited#######################
post '/posts' do
  redirect to '/' unless logged_in?
  user = User.find_by(id: session[:user_id])
  @post = Post.new
  @post.categories = params[:categories]
  @post.heading = params[:heading]
  @post.want = params[:want]
  @post.give = params[:give]
  @post.body = params[:body]
  @post.image = params[:image]
  @post.avaliablity = params[:avaliablity]
  @post.user_id = session[:user_id]
  @post.user_email = user.email
  @post.save
  redirect :'/'
end

######### Shows each post on a saperate Page#######################################
get '/posts/:id' do
  @post = Post.find params[:id]
  erb :show
end



############## Get the edit form for an existing post  #########################
get '/posts/:id/edit' do
  redirect to '/login' unless logged_in?
  @post = Post.find params[:id]
  erb :edit
end


############################ Editing form for a post #############################
put '/posts/:id' do
  redirect to '/login' unless logged_in?
  @post = Post.find(params[:id])
  @post.categories = params[:categories]
  @post.heading = params[:heading]
  @post.want = params[:want]
  @post.give = params[:give]
  @post.body = params[:body]
  @post.image = params[:image]
  @post.avaliablity = params[:avaliablity]
  @post.save

  redirect to :"/posts/#{params[:id]}"
end


####################### Deleting the existing post with specific id ##################
delete '/posts/:id' do
  redirect to '/login' unless logged_in?

  @post = Post.find(params[:id]).destroy
  @post.save
  redirect to "/"

end

###################### Send Email #########################
post '/email/:id' do
  # post = Post.all
  # binding.pry
  post = Post.find(params[:id])

  request = PostageApp::Request.new(
    :send_message,
    {
      headers: {
        from: "#{params[:from_email]}",
        subject: "#{params[:heading]}"
      },
      recipients: "#{post.user.email}",
      content: {
        'text/plain' => "#{params[:body]}",
        # 'text/html' => 'html email content'
      }
    }
  )

  response = request.send

  redirect to :"/posts/#{params[:id]}"
end













# --------------------------------
# authentication
#---------------------------------


######################################## show signup form ###################################
get '/signup' do
  erb :signup
end

################################# show login form ###########################################
get '/login' do
  erb :login
end

########################## gets the singup form when singup page is visited ###########

put '/session' do
  @user = User.new
  @user.firstname = params[:firstname].capitalize
  @user.lastname = params[:lastname].capitalize
  @user.email = params[:email].downcase
  @user.password = params[:password]
  @user.save

  user = User.find_by(email: params[:email].downcase)

  if user && user.authenticate(params[:password])
    # yay
    # create a session
    session[:user_id] = user.id
    session[:user_email] = user.email
    # redirect user
    redirect to '/'
  else
    # nay
    # redirect user
    redirect to '/login'
  end
end

################## creating a session creating one seasion so no seasions name ########
post '/session' do

  user = User.find_by(email: params[:email].downcase)

  if user && user.authenticate(params[:password])
    # yay
    # create a session
    session[:user_id] = user.id
    # redirect user
    redirect to '/'
  else
    # nay
    # redirect user
    redirect to '/login'
  end
end


######################## when a user wants to log out #################################
delete '/session' do
  session[:user_id] = nil
  redirect to '/login'
end

get '/session' do
  redirect to '/login'
end




######################## User Info ####################################################
get '/:name' do
  redirect to '/login' unless logged_in?
  @user = User.find_by(id: session[:user_id])
  params[name: @user.firstname]
  erb :userInfo
end


get '/:name/edit' do
redirect to '/login' unless logged_in?
@user = User.find_by(id: session[:user_id])

erb :useredit
end


put '/useredit' do
  @user = User.find_by(id: session[:user_id])
  @user.firstname = params[:firstname].capitalize
  @user.lastname = params[:lastname].capitalize
  @user.email = params[:email].downcase
  @user.mobile = params[:mobile]
  @user.address = params[:address]
  @user.postcode = params[:postcode]
  @user.suburb = params[:suburb]
  @user.state = params[:state]
  @user.image = params[:image]
  @user.save

  redirect to '/'
end
