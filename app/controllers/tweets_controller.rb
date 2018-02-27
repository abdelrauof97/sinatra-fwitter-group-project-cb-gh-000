require './config/environment'
require 'rack-flash'
require 'pry'

class TweetsController < ApplicationController
  
  use Rack::Flash
    
  get '/tweets' do 
    redirect '/login' unless logged_in? 
    @user = current_user
    erb :'/tweets/index' 
  end 
    
  get '/tweets/new' do 
    if logged_in?
      erb :'/tweets/new'
    else 
      redirect '/login'  
    end
  end
    
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = @tweet.user
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end
    
  post '/tweets' do 
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @user = User.find(current_user.id)
      @tweet.user = @user
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end 
    redirect '/tweets/new'
  end
    


  
  get '/tweets/:id/edit' do 
    redirect '/login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' unless @tweet.user == current_user
    erb :'/tweets/edit'
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
    redirect "/tweets/#{@tweet.id}/edit"
  end
  

  delete '/tweets/:id/delete' do 
    redirect '/' unless logged_in?
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    end
    redirect '/tweets'
  end
    
end 







