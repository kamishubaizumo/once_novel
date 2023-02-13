Rails.application.routes.draw do

  namespace :public do
    get 'bookmarks/index'
  end
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    root to: "users#index"
    resources :users, only:[:index,:show,:edit,:update]
    resources :genres, only:[:index,:create,:edit,:update]
end





# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about"


    resources :users, only: [:index,:show,:create,:edit,:update,:destroy] do

      #退会確認画面
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
      #論理削除のルーティング
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"

      #resourcesではなく、resource。フォロー・フォロワー
      resource :relationships, only: [:create,:destroy]
      get "followings" => "relationships#followings", as: "followslist"
      get "followers" => "relationships#followers", as: "followerslist"



          #ブックマーク一覧
      get "bookmarks" => "bookmarks#bookmarks", as: "bookmarkslist"

    end


    #作品
    resources :novels, only: [:index,:new,:create,:show,:edit,:update,:destroy] do
      #感想と評価
      resources :reviews, only: [:index,:create,:destroy]

      #ユーザーのbookmark(お気に入り)
      resource :bookmarks, only: [:create,:destroy]

    end

  end

  #検索
  get "search" => "searches#search"
end

