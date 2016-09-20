class VotesController < ApplicationController

  def up_vote
      update_val! 1
  end

  def down_vote
      update_val! -1
  end

  def update_val! value
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: current_user.id).first

    if @vote
        authorize @vote, :update?
        @vote.update_attribute(:value, value)
      else
        @vote = current_user.votes.build(value: value, post: @post)
        authorize @vote, :create?
        @vote.save
      end
      
      redirect_to :back
  end 
end