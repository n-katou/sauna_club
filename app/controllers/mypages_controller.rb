class MypagesController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
    @posts = @customer.posts.page(params[:page])
  end
end
