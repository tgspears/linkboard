class VotesController < ApplicationController
	def create
		if params.key?(:post_id)
			thing = Post.find_by_id(params[:post_id])
		elsif params.key?(:user_id)
			thing = User.find_by_id(params[:user_id])
		else
			return render plain: "Invalid input."
		end

		my_vote = thing.votes.find_by_user_id(current_user.id)

		if my_vote.nil?
			current_user.ratings << thing.votes.create(votes_params)
		else
			if(params[:vote][:value].to_i != my_vote.value)
				my_vote.value = params[:vote][:value]
				my_vote.save
			else
				flash[:danger] = "You already voted on this."
			end
		end
		respond_to do |format|
			format.json { render json: {result:true,votes:thing.votes}}
			format.html{redirect_to :posts}
		end
	end

	private

	def votes_params
		params.require(:vote).permit(:value)
	end
end