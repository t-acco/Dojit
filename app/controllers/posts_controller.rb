class PostsController < ApplicationController
  def index
    @posts = Post.last_week_post(current_user).paginate(page: params[:page], per_page: 10)
  end
end