class PostsController < ApplicationController

	before_action :is_authenticated?

	def index
		@vote = Vote.new
    	@posts = Post.all
    	@comments = Comment.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.create(post_params)
		redirect_to posts_path
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title,:link)
	end
	
end