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

    #管理者権限で、ユーザーの退会、復活をできるようにした。routes.rbにもroutingを書き足した。
    def withdrawal
        @user = User.find(params[:id])


        if @user.email == 'guest@example.com'
          flash[:notice] = "ゲストユーザーは退会できません"
          redirect_to admin_root_path
          #削除しようとしたら、トップ画面へリダイレクト
        else
        #!をつけて、true/falseを反転させて、有効、退会を切り替えることができる。
        @user.update(is_deleted: !@user.is_deleted)

            if @user.is_deleted

        #ユーザーが退会したとき、update_allで、全ての投稿を非公開にする。
               @user.novels.update_all(novel_status: "novel_private")
             #感想を全て物理削除する
               @user.reviews.destroy_all
               flash[:notice] = "退会処理を実行いたしました"
            else
               flash[:notice] = "有効にします"
            end
          redirect_to admin_root_path
        end
    end

end
