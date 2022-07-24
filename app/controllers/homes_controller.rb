class HomesController < ApplicationController
  def top
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)
  end

  def about
  end

  def error
  end

end
