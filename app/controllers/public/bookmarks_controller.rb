class Public::BookmarksController < ApplicationController



  def create
    @novel = Novel.find(params[:novel_id])
    bookmark = current_user.bookmarks.new(novel_id: @novel.id)
    bookmark.save


    # 非同期通信なのでコメントアウト。
    #request.referetはその場にリダイレクトする、
    #redirect_to request.referer
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    bookmark = current_user.bookmarks.find_by(novel_id: @novel.id)
    bookmark.destroy

    #非同期通信なのでコメントアウト。
   # redirect_to request.referer
  end


  #ルートがユーザー側にあるブックマーク一覧

  def bookmarks

  #自分にだけ表示させるけど、エラーが出るので書き換え
    #user = current_user
    #@novels = user.novels


    #他の人のブックマークを見たいからuser情報を取ってくる。
    user = User.find(params[:user_id])
    @bookmarks = user.bookmarks

    #部分テンプレートに必要
    @user = User.find(params[:user_id])

  end
end
