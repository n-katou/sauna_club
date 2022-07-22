class PostsController < ApplicationController
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_customer.posts.new(post_params) #この記述じゃないとエラーが出る理由はなぜか。おそらくcustomerの情報を欲しいからcurrent_customerをいれている。
    # byebug
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC").page(params[:page]).per(5)  #投稿ごとにコメントを表示させたい　記述方法を知りたい。今の記述でそれができた。
  end

  #キーワード検索
  def posts_search
    @posts = Post.posts_search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render "index"
  end

  #タグ検索
  def tags_search
    @posts = Post.tags_search(params[:keyword]).page(params[:page])
    @keyword2 = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :post_content, tag_ids: []) #tag_ids: []は配列を取り出す記述。
  end

end
