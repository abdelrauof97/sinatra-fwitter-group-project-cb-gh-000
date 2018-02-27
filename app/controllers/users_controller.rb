require './config/environment'
require_relative '../helpers/helpers.rb'
require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash

  get '/signup' do 
    redirect '/tweets' if logged_in?
    erb :'/users/signup'
  end
  
  post '/signup' do 
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password]) 
      login(@user)
      flash[:message] = "Welcome, #{@user.username}"
      redirect "/tweets"
    else 
      redirect '/signup'
    end 
  end
  
  get '/login' do 
    redirect '/tweets' if logged_in?
    erb :'/users/login'
  end 
  
  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
      flash[:message] = "You Have Logged in Succefuly"
      redirect "/tweets"
    end
    redirect '/login'
  end
  
  get '/logout' do 
    if logged_in?
      logout!
    end 
    redirect '/login'
  end
  
    
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end



