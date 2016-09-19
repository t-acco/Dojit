class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    authorize @comment
  end

  def create

    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post

    authorize @comment

    if (@comment.save)
      flash[:notice] = "Comment was saved"
    else
      flash[:error] = "Error saving command"
    end

    redirect_to [@post.topic, @post]

  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
