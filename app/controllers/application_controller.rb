class ApplicationController < ActionController::Base
  before_action :restrict_guest_user,only:[:update,:create,:destroy], unless: :devise_controller? #ゲストの閲覧のみのメソッド

  #ゲストログインで投稿のみ閲覧メソッド
  def restrict_guest_user
    if current_customer&.guest? # &あることによって、エラーを出さずに通過させられる。
      redirect_to posts_path,alert: "ゲストユーザーは書き込み出来ません"
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_home_path
    when Customer
      mypage_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      root_path
    end
  end
end
