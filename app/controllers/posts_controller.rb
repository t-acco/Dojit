class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic
    authorize @post

    if @post.save
      @topic = Topic.find(params[:topic_id])
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    authorize @post
  end


  def update
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
