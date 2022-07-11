class FavoritesController < ApplicationController
  def index
    favorites = Favorite.all
    @favorites= current_customer.favorites
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id) #post_id: post.idこれの意味は？
    favorite.destroy
    redirect_to post_path(post)
  end
end
