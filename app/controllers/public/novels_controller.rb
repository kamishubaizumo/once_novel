class Public::NovelsController < ApplicationController

  def index
    # @novels = Novel.all
    # @genres = Genre.all
    # @tag = Tag.all

    #kaminariを使ったページネーション
      if params[:genre_id].blank?
      # genre_idが空かどうかをblank?で確かめる。blank? =　空のオブジェクトを判定

      @novels = Novel.page(params[:page]).per(20)
      @genres = Genre.all
      @index = "Novel"

    else


      #no methodエラーで怒られる。
     #Genre.all　ではなく、Genre.params[:genre_id]で値をひとつ取ってくる。
        @genre = Genre.find(params[:genre_id])
        @novels = @genre.novels.page(params[:page]).per(20)
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
      #中間テーブルに保存。novelとgenre_idの紐づけ。難しい。
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
  end

  def update
    @novel = Novel.find(params[:id])


    if @novel.update(write_novel_params)
      #タグを更新。novelとgenre_idを更新
       @tag = Tag.update(novel_id: @novel.id,genre_id: params[:novel][:genre_id])


      flash[:notice] = "更新に成功しました"
      redirect_to novel_path(@novel.id)
    end

  end

  def destroy
  end

  # 投稿データのストロングパラメータ
  private

  def write_novel_params
    params.require(:novel).permit(:title, :logline, :foreword, :body, :afterword, :novel_status, :tags,
                                  tags_attributes: [:id, :genre_id])
  end

end
