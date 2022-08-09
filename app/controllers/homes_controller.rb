class HomesController < ApplicationController
  def top
    #@posts = Kaminari.paginate_array(Post.all.shuffle).page(params[:page]).per(5)  #Kaminari.paginate_array()　配列ではこれを使用すると良い。
    if ActiveRecord::Base.connection_config[:adapter] == 'sqlite3'
      @posts = Post.order('RANDOM()').page(params[:page]).per(5)
    elsif ActiveRecord::Base.connection_config[:adapter] == 'mysql2'
      @posts = Post.order('RAND()').page(params[:page]).per(5)
    end
  end

  def about
  end

  def error
  end

end
