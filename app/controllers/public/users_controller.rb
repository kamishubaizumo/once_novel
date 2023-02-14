class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  #ゲストユーザーはユーザー編集できない
  before_action :ensure_guest_user, only: [:edit]


  def show
    @user = User.find(params[:id])
    @novels = @user.novels


    #パラメータのノベルステータスに、値があるかどうか
    if params[:novel_status].present?
      @novels = @novels.where(novel_status: params[:novel_status])
    else
      @novels = @novels.where(novel_status: "novel_public")
    end

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
      unless @user == login_user_id
      redirect_to user_path(current_user)
      end
    end

      #ゲストは名前を変えたらログインできなくなるので、編集させない
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
    end

end
