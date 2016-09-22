class CommentsController < ApplicationController
  respond_to :html, :js

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    authorize @comment
  end

  def create

    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if (@comment.save)
      flash[:notice] = "Comment was saved"
    else
      flash[:error] = "Error saving command"
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
    #  redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
     # redirect_to [@post.topic, @post]
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
