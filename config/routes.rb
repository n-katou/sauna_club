Rails.application.routes.draw do
  root to: "homes#top"

  get '/' => "homes#top", as: "home"
  get '/about' => "homes#about", as: "about"

  resources :posts

  get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "/customers/withdraw" => "customer#withdraw", as: "withdraw"
  resources :customers, only: [:index,:show,:edit,:update] do
    resources :favorites, only: [:index,:destroy,:create]
    resources :comments, only: [:edit,:create,:update,:destroy]
  end

  resource :relationships,only: [:create,:destroy]

  get "/mypage" => "mypages#show"

  get "/followings" => "followers#index"

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
  }


  namespace :admin do
    get "/" => "homes#top", as: "admin_home"

    resources :posts, only: [:index,:show,:edit,:destroy,:update]

    resources :tags, only: [:index,:create,:edit,:destroy,:update]

    resources :customers, only: [:index,:show,:edit,:update]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
