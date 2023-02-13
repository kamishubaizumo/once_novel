class Public::NovelsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    #novel_statusが公開(0)のものを一覧表示する。

    #kaminariを使ったページネーション
     if params[:genre_id].blank?
      # genre_idが空かどうかをblank?で確かめる。blank? = 空のオブジェクトを判定

      @novels = Novel.where(novel_status: "novel_public").page(params[:page]).per(20)
      @genres = Genre.all
      @index = "Novel"

     else

     #Genre.allではなく、Genre.params[:genre_id]で値をひとつ取ってくる。
        @genre = Genre.find(params[:genre_id])

        #ジャンルからノベルら取ってきて、公開しているものを表示する。
        @novels = @genre.novels.where(novel_status: "novel_public").page(params[:page]).per(20)
        @novels_all = @genre.novels.count
        @genres = Genre.all
        @index = @genre.genre
     end
  end


  def show
    @novel = Novel.find(params[:id])
  end

  def new
    #新規投稿
    @write = Novel.new



    #非公開か公開を選ぶ
  end

  def create
    @write = Novel.new(write_novel_params)
    @write.user_id = current_user.id

    if @write.save
      #中間テーブルに保存。novelとgenre_idの紐づけ。何をやってるのか理解はできていない。
      @tag = Tag.new(novel_id: @write.id,genre_id: params[:novel][:genre_id])
      #メンターさんに教わった。正直、まだよくわからない。

      @tag.save
      redirect_to novel_path(@write.id)
    else
      render :new
    end


    #非公開、公開で登録。
  end

  def edit
    @novel = Novel.find(params[:id])
    #ジャンルを変更する
    #非公開、公開を変更する


    #"0","1"の文字列でエラーが起きた。もし、ステータスがnovel_privateなら1
    if @novel.novel_status == "novel_private"

      @selected = 1
    else
      @selected = 0
    end



  end


  def update
    @novel = Novel.find(params[:id])

    updateParams = write_novel_params
    updateParams[:novel_status] = updateParams[:novel_status].to_i
    if @novel.update(updateParams)
      #novel.tags.first ノベルの最初に選んだタグ(中間テーブル)がnil(無い)場合
      if @novel.tags.first == nil
        #タグを新たにノベルIDと紐づける。　ノベルidとジャンルIDを紐づける。ここはまだ理解できていない。
        @tag = Tag.new(novel_id: @novel.id, genre_id: params[:novel][:genre_id])
        #タグをセーブ
        @tag.save()
      else
        #対象を選んで、ノベルの最初のタグを更新。ノベルIDは、ノベルのIDとジャンルID。ノベルのジャンルIDを更新。
        @tag = @novel.tags.first.update(novel_id: @novel.id, genre_id: params[:novel][:genre_id])
      end
      flash[:notice] = "更新に成功しました"
      redirect_to novel_path(@novel.id)

      # 公開非公開を更新



    end

  end

  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    redirect_to user_path(current_user)

  end

  # 投稿データのストロングパラメータ
  private

  def write_novel_params
    params.require(:novel).permit(:title, :logline, :foreword, :body, :afterword, :novel_status, :tags,
                                  tags_attributes: [:id, :genre_id])
  end



  # 他人が他人の作品を編集できないように、editページに行くと遷移させる。
    def is_matching_login_user
      @novel = Novel.find(params[:id])
      user_id = @novel.user.id
      login_user_id = current_user.id
      if(user_id != login_user_id)
        redirect_to novels_path
      end
    end

end
