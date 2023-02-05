class Admin::UsersController < ApplicationController

  def index
    @users = User.all
    # ユーザーの小説数を表示
    # @user = User.find(params[:id])
    # @user_novel = @user.novel.count


  end

  def show
    @user = User.find(params[:id])

  end

end
