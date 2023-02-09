Rails.application.routes.draw do

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
      resources :relationships, only: [:create,:destroy]
      get "followings" => "relationships#followings", as: "followslist"
      get "followers" => "relationships#followers", as: "followerslist"
    end


    resources :novels, only: [:index,:new,:create,:show,:edit,:update,:destroy] do
    


    resources :reviews, only: [:index,:create,:edit,:update]

    end

    #Review(comments)のルート

    #relation

    #bookmark


  end
end

