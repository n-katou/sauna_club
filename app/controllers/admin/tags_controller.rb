class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all.order("created_at ASC").page(params[:page]).per(5)
    @tag = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    tag.save
    redirect_to admin_tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    redirect_to admin_tags_path
  end


  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
