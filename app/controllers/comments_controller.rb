class CommentsController < ApplicationController


	def show
		
	end

	def index
		# render :json => params
		@post = Post.find(params[:post_id])
		@comments = @post.comments
		@comment = Comment.new
	end

	def new
	end

	def create
		@comment = Post.find(params[:post_id]).comments.create(comment_params)
		redirect_to post_comments_path
		@vote = Vote.new
		# render :json => params
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end