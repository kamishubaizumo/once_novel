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
  end
  
  #フォロワーリスト
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
