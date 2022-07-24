class HomesController < ApplicationController
  def top
    @posts = Post.all.order("RAND()").limit(5)
  end

  def about
  end

  def error
  end

end
