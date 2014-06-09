class TweetsController < ApplicationController
	before_action :authenticate_user!
	before_action :authorize, only: [:edit, :destroy]
	before_action :load_tweet, only: [:edit, :update, :destroy]
	def index
		@tweets = Tweet.all.paginate(:page => params[:page], :per_page => 3)
		#@tweets = Tweet.search(params[:search])
	end

	def new
		@tweet = Tweet.new
	end

	def create
	   @tweet = Tweet.new(tweet_params)
	   @tweet.user_id = current_user.id
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
	def authorize
      if @tweets.user_id == current_user.id
         flash[:notice] = "You successfully done it " 

      else
        flash[:notice] = "You Don't have permission to do this "
        redirect_to tweets_path 
      end
    
  end

	private
	def load_tweet
		@tweet = Tweet.find(params[:id])
	end
	def tweet_params
		params.require(:tweet).permit(:title, :message, :user_id)
	end
end
