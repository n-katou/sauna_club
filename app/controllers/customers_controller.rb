class CustomersController < ApplicationController
  def index
    @customers = Customer.where(is_active: true).order("created_at ASC").page(params[:page]).per(7)
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order("created_at ASC").page(params[:page]).per(5)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(customer_params)
    redirect_to mypage_path(current_customer.id)
  end

  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end

  def withdraw
    @customer = current_customer
    # binding.pry
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    # binding.pry
    params.require(:customer).permit(:profile_image,:account_name,:birth_date,:email,:is_active,:introduction)
  end

end
