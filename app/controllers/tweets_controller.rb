class TweetsController < ApplicationController
	before_action :load_tweet, only: [:edit, :update, :destroy]
	def index
		@tweets = Tweet.all
	end

	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweet_params)
		if @tweet.save
		   redirect_to tweets_path, notce: "Tweet Created successfully"
        else
        	render :new
        end
	end

	def edit
		
	end

	def update
		 if @tweet = Tweet.update(tweet_params)
		 	flash[:notce] = "your tweet has been updated!"
		    redirect_to tweets_path
	     else
	        flash[:notce] = "sorry try again"
		    render :edit
	     end 
	end

	def destroy
		@tweet.destroy
		redirect_to tweets_path
		
	end

	private
	def load_tweet
		@tweet = Tweet.find(tweet_params)
	end
	def tweet_params
		params.require(:tweet).permit(:title, :message)
	end
end
