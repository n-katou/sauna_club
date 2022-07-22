class HomesController < ApplicationController
  def top
    @posts = Post.order("RANDOM()").limit(4)
  end

  def about
  end

  def error
  end

end
