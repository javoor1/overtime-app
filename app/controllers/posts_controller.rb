class PostsController < ApplicationController
	before_action :set_post, only: [:show]

	def index
	end

	def new
		@post = Post.new
	end

	def create
		puts params.inspect
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post, notice: "Your post was created succesfully"
		else
			render :new
		end	
	end

	def show
		@post = Post.find_by_id(params[:id])
	end

	private

	def post_params
		params.require(:post).permit(:date, :rationale)
	end

	def set_post
		@post = Post.find_by_id(params[:id])
	end

end
