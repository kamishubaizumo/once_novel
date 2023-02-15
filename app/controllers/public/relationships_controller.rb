class Public::RelationshipsController < ApplicationController

  #フォローする
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  #フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end


  #フォローリスト
  def followings
    user = User.find(params[:user_id])
    @users = user.followings

    #部分テンプレートに必要
    @user = User.find(params[:user_id])

  end

  #フォロワーリスト
  def followers
    user = User.find(params[:user_id])
    @users = user.followers

    #部分テンプレートに必要
    @user = User.find(params[:user_id])
  end
end
