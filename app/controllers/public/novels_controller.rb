class Public::NovelsController < ApplicationController

  def index
    @novels = Novel.all
    


    @genres = Genre.all
    @tag = Tag.all


  end

  def show
    @novel = Novel.find(params[:id])
    @genre = Genre.find(params[:id])


  end

  def new
    #新規投稿
    @write = Novel.new

    #非公開か公開を選ぶ



  end

  def create
    @write = Novel.new(write_nobel_params)
    @write.user_id = current_user.id

    if @write.save
      redirect_to novel_path(@write.id)
    else
      render :new
    end

    #選んだジャンルで登録
    #非公開、公開で登録。

  end

  def edit

    #ジャンルを変更する
    #非公開、公開を変更する
  end

  def update

  end

  def destroy
  end

  # 投稿データのストロングパラメータ
  private

  def write_nobel_params
    params.require(:novel).permit(:title, :logline, :foreword, :body, :afterword, :novel_status, :genre)
  end

end
