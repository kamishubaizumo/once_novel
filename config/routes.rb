Rails.application.routes.draw do

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
    get "about" => "publick/homes#about"


    resources :users, only: [:index,:show,:create,:edit,:update,:destroy]
      #退会確認画面
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
      #論理削除のルーティング
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"


    resources :novels, only: [:index,:create,:show,:edit,:update,:destroy]

    #Review(comments)のルート

    #relation

    #bookmark


  end
end

