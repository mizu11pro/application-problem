Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # 自動住所検索
  
  root to: 'homes#top'
  get 'mypage', to: 'homes#mypage'
  # 自動住所検索
  get '/home/about' => 'homes#about'
  get 'search' => 'searches#search'

  resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
  end
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy ] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    # get 'favorites' => 'favorites#favorites'
  end
end
