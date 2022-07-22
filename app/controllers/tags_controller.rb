class TagsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @tags = Tag.all.order("created_at ASC").page(params[:page]).per(10)
  end
end
