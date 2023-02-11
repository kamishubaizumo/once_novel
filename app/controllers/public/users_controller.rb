class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]


  def index
  end

  def show
    @user = User.find(params[:id])
    @novels = @user.novels




  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "プロフィールを更新しました"
    else
      render :edit
    end

  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end



  private

  def user_params
    # permitに,:email,:passwordは設定したらダメっぽい。更新するとログアウトする。
    params.require(:user).permit(:name,:infomation)
  end

  # 他人のプロフィール編集をできないように、editページに行くと、遷移させる。
    def is_matching_login_user
      @user = User.find(params[:id])
      login_user_id = current_user.id
      unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
