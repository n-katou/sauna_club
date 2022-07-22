class CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def edit
    @comment = Comment.find(params[:post_id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = post.id
    if @comment.save
      redirect_to post_path(post.id)
    else
      @error_comment = @comment
      @post = Post.find(params[:post_id])
      @coment = Comment.new
      @comments = Comment.all
      render "posts/show"
    end
  end

  def update
    comment = Comment.find(params[:post_id])
    comment.update(comment_params)
    redirect_to post_path(comment.post.id) #coment.post_idか？
  end

  def destroy
    comment = Comment.find(params[:post_id])
    comment.destroy
    redirect_to post_path(comment.post.id) #coment.post_idか？
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
