class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.order("created_at ASC").page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order("created_at ASC").page(params[:page]).per(5)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer.id)
  end

  private

  def customer_params
    # binding.pry
    params.require(:customer).permit(:profile_image,:account_name,:birth_date,:email,:is_active,:introduction)
  end

end
