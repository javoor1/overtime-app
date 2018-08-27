class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
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

	def edit
	end

	def update
		@post.update(post_params)
		redirect_to @post, notice: "Your post was edited succesfully"
	end

	def show
		@post = Post.find_by_id(params[:id])
	end

	def destroy
		@post.delete
		redirect_to posts_path, notice: "Your post was deleted succesfully"
	end

	private

	def post_params
		params.require(:post).permit(:date, :rationale)
	end

	def set_post
		@post = Post.find_by_id(params[:id])
	end

end
