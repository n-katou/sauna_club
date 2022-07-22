class MypagesController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(current_customer.id)
    @posts = @customer.posts.order("created_at DESC").page(params[:page])
  end
end
