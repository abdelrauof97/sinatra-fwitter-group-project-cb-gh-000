require './config/environment'
require 'rack-flash'


class TweetsController < ApplicationController
  
  use Rack::Flash
    
  get '/tweets' do 
    redirect '/login' unless logged_in? 
    @user = current_user
    erb :'/tweets/index' 
  end 
    
  get '/tweets/new' do 
    erb :'/tweets/new' if logged_in?
  end
    
  post '/tweets' do 
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @user = User.find(current_user.id)
      @user.tweets << @tweet
      @tweet.user = @user
      redirect "/tweets/#{@tweet.id}"
    end 
    redirect '/tweets/new'
  end
    
  get '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    @user ||= @tweet.user
    erb :'/tweets/show' if logged_in?
  end
  
  get '/tweets/:id/edit' do 
    redirect '/login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      erb :'/tweets/edit' 
    end
    redirect '/tweets'
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
    redirect "/tweets/#{@tweet.id}/edit"
  end
  
  post '/tweets/:id/delete' do 
    redirect '/login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
      @tweet.delete
    end
    redirect '/tweets'
  end

    
end 







