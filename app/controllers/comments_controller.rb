class CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :block_comment_customer, only: [:edit,:update]

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comments = @post.comments.order("created_at DESC").page(params[:page]).per(5)
    if @comment.save
      render :create #jsを読み込んでいる
      # redirect_to post_path(@post.id)
    else
      render :error #jsを読み込んでいる
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post.id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    if @comment.destroy
      redirect_to post_path(@comment.post.id) #coment.post_idか？
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

  #投稿者以外に編集させないメソッド
  def block_comment_customer
    unless Comment.find(params[:id]).customer.id.to_i == current_customer.id
      redirect_to posts_path
    end
  end

end