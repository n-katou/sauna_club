class MypagesController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end
end
