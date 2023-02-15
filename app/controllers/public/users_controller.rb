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


  #退会処理　ゲストユーザー用に書き換え。ちなみに、User.find(params[:id]) から current_userにすることで、エラー解消。
  def withdrawal

    @user = current_user

    if @user.email == 'guest@example.com'
      reset_session
      flash[:notice] = "ゲストユーザーは退会できません"
      redirect_to :root
      #削除しようとしたら、トップ画面へリダイレクト
    else

    @user.update(is_deleted: true )

    #ユーザーが退会したとき、update_allで、全ての投稿を非公開にする。
    @user.novels.update_all(novel_status: "novel_private")

    #感想を全て物理削除する
    @user.reviews.destroy_all
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
    end

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

      #ゲストはメアドを変えたらログインできなくなるので、編集させない。退会URLを打ち込まれると退会できてしまう問題。
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.email == 'guest@example.com'
        redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
    end

end
