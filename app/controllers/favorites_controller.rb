class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "The post added to your favorites"
      # Add code to generate a success flash and redirect to @post
      # Remember the path shortcut: [@post.topic, @post]
    else
      flash[:error] = "Error occur while trying to add favorite. please try again!" 
      # Add code to generate a failure flash and redirect to @post
    end

    redirect_to [@post.topic, @post]
  end

  def destroy
  # Get the post from the params
  @post = Post.find(params[:post_id])
  # Find the current user's favorite with the ID in the params
  favorite = current_user.favorites.where(post_id: @post.id).first

  authorize favorite

  if favorite.destroy
    flash[:notice] = "favorites was dismissed"
  else
    flash[:error] = "Unable to dismisse favorite"
   end

   redirect_to [@post.topic, @post]
  end
end
