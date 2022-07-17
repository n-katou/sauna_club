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
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments  #投稿ごとにコメントを表示させたい　記述方法を知りたい。今の記述でそれができた。
  end

  #キーワード検索
  def posts_search
    @posts = Post.posts_search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  #タグ
  def tags_search
    @posts = Tag.tags_search(params[:keyword])
    @keyword2 = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :post_content, tag_ids: []) #tag_ids: []は配列を取り出す記述。
  end

end
