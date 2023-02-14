class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(20)
    # ユーザーの小説数を表示
    # @user = User.find(params[:id])
    # @user_novel = @user.novel.count


  end

  def show
    @user = User.find(params[:id])
    
    #ユーザーの管理者権限で、退会処理
    @withdrow


  end

end
