class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = current_customer.posts.new(post_params)
    # byebug
    post.save
    redirect_to post_path(post.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :post_content, tag_ids: [])
  end

end
