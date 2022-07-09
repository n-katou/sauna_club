class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
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
