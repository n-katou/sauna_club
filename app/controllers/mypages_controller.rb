class MypagesController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
    @posts = @customer.posts.order("created_at DESC").page(params[:page])
  end
end
