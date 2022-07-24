class HomesController < ApplicationController
  def top
    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @posts = Post.order(rand).limit(5)
  end

  def about
  end

  def error
  end

end
