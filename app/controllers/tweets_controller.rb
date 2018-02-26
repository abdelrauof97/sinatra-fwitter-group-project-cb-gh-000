require './config/environment'

class TweetsController < ApplicationController
    
  get '/tweets' do 
    erb :index
  end 
    
  get '/tweets/new' do 
    erb :'/tweets/new'
  end
    
  post '/tweets' do 
    @tweet = Tweet.create(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end
    
  get '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
  
  get '/tweets/:id/edit' do 
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end
    
end 




