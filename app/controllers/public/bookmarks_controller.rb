class Public::BookmarksController < ApplicationController



  def create
    novel = Novel.find(params[:novel_id])
    bookmark = current_user.bookmarks.new(novel_id: novel.id)
    bookmark.save
    redirect_to novel_path(novel)
  end



  def destroy
    novel = Novel.find(params[:novel_id])
    bookmark = current_user.bookmarks.find_by(novel_id: novel.id)
    bookmark.destroy
    redirect_to novel_path(novel)
  end


  #ルートがユーザー側にあるブックマーク一覧

  def bookmarks

    #user = current_user
    #@novels = user.novels


    #他の人のブックマークを見たいからuser情報を取ってくる。
    user = User.find(params[:user_id])
    @bookmarks = user.bookmarks

  end
end
