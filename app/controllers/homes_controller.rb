class HomesController < ApplicationController
  def top
    @posts = Kaminari.paginate_array(Post.all.shuffle).page(params[:page]).per(5)  #Kaminari.paginate_array()　配列ではこれを使用すると良い。
  end

  def abouteit
  end

  def error
  end

end
