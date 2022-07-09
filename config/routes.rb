Rails.application.routes.draw do
  root to: "homes#top"

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
  }

  get '/' => "homes#top", as: "home"
  get '/about' => "homes#about", as: "about"

  resources :posts do
    resources :favorites, only: [:destroy,:create]
    resources :comments, only: [:edit,:create,:update,:destroy]
  end
  get "/favorites" => "favorites#index",as: "favorites"

  get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "/customers/withdraw" => "customer#withdraw", as: "withdraw"
  resources :customers, only: [:index,:show,:edit,:update]

  resource :relationships,only: [:create,:destroy]

  get "/mypage" => "mypages#show"

  get "/followings" => "followers#index"


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top", as: "home"

    resources :posts, only: [:index,:show,:edit,:destroy,:update]

    resources :tags, only: [:index,:create,:edit,:destroy,:update]

    resources :customers, only: [:index,:show,:edit,:update]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
