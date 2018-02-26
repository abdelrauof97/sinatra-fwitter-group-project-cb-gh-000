require './config/environment'

class UsersController < ApplicationController

  get '/signup' do 
    erb :'/users/signup' 
  end
  
  post '/signup' do 
    @user = User.create(username: User.slug(params[:username]), email: params[:email], password: params[:password]) 
    if @user 
      session[:id] = @user.id 
      erb :'users/signedup'
    else 
      erb :'/users/failure'
    end 
  end
  
  get '/login' do 
    erb :'/users/login'
  end 
  
  post '/login' do 
    @user = User.find_by_slug(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      erb :'users/loggedin'
    else 
      erb :'/users/failure'
    end
  end
  
  get '/logout' do 
    session.clear
    erb :'/users/logout'
  end

end



