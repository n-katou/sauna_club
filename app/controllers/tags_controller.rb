class TagsController < ApplicationController
  def index
    @tags = Tag.all.order("created_at ASC").page(params[:page]).per(10)
  end
end
