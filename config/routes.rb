Rails.application.routes.draw do


  get 'tags/index'
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
  }

  devise_scope :customer do
    post 'customer/guest_sign_in', to: 'customer/sessions#new_guest' #ゲストログイン
  end

  root to: "homes#top"
  get '/about' => "homes#about", as: "about"
  get "/error" => "homes#error", as: "error"

  get '/posts/search' => "posts#posts_search", as: "posts_search" #会員検索用
  get '/tags/search' => "posts#tags_search", as: "tags_search" #会員検索用

  resources :posts do
    resource :favorites, only: [:destroy,:create] #なぜリソース
    resources :comments, only: [:edit,:create,:update,:destroy]
  end
  get "/favorites" => "favorites#index",as: "favorites"

  get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "/customers/withdraw" => "customers#withdraw", as: "withdraw"

  resources :customers, only: [:index,:show,:edit,:update] do

  resource :relationships,only: [:create,:destroy]
  get "followings" => "relationships#followings", as: "followings"
  get "followers" => "relationships#followers", as: "followers"

  end

  get "/mypage" => "mypages#show"

  get "/tags" => "tags#index"


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top", as: "home"

    get '/posts/search' => "posts#posts_search", as: "posts_search" #管理者検索用
    get '/tags/search' => "posts#tags_search", as: "tags_search" #管理者検索用

    resources :posts, only: [:index,:show,:edit,:destroy,:update]

    resources :tags, only: [:index,:create,:edit,:destroy,:update]

    resources :customers, only: [:index,:show,:edit,:update]

    resources :comments, only: [:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
