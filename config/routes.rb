Rails.application.routes.draw do

  devise_for :users
  # deviseを使用した際のURLとしてuserを含むことを示している
  # controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations',
  # }
  # 自動住所検索(sign_upできなくなる)

  root to: 'homes#top'
  # get 'mypage', to: 'homes#mypage'
  # 自動住所検索(sign_upできなくなる)
  get '/home/about' => 'homes#about'
  get 'search' => 'searches#search'
  # 検索内容用のページ

  resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    # resources :books, except: [:destroy]
    # except: [destroy] destroyのみ除外する
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  # doで親子関係 通称ネストする
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy ] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    # get 'favorites' => 'favorites#favorites'
  end
end
