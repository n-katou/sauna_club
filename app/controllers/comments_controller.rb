class CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_customer.posts.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post.id)
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to post_path(post.id) #coment.post_idか？
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(post.id) #coment.post_idか？
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
