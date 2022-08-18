# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  # フォローする時
  def create
    current_customer.follow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
    # redirect_to request.referer
    # render :create ←これはjsファイルが同じcreateyだから書かなくても良い
  end

  # フォローはずす時
  def destroy
    current_customer.unfollow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
    @customers = current_customer.followings.order("created_at ASC").page(params[:page]).per(5)
    # ↓jsとhtmlを分ける記述方法
    # respond_to do |format|
    #   format.html { redirect_to root_path }
    #   format.js { render 'relationships/destroy.js.erb' }
    # end
    # render :destroy　←これはjsファイルが同じdestroyだから書かなくても良い。
    # redirect_to request.referer #request.refererでそのページに戻るという意味
  end

  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.order("created_at ASC").page(params[:page]).per(5)
  end

  # 　フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.order("created_at ASC").page(params[:page]).per(5)
  end
end
