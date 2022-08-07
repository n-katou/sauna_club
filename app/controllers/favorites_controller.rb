class FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @favorites= current_customer.favorites.order("created_at DESC").page(params[:page])
    # @favorites = Favorite.where.not(customer_id: current_customer.id).group(:post_id)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
    render :favorite
    # redirect_to post_path(post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id) #post_id: post.idこれの意味は？
    favorite.destroy
    render :favorite
    # redirect_to post_path(post.id)
  end
end
