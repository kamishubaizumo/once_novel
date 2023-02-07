class Public::NovelsController < ApplicationController

  def index
    @novels = Novel.all
    @genres = Genre.all
  end

  def show
    @novel = Novel.find(params[:id])
  end

  def new
    @write = Novel.new


  end

  def create
    @wirte = Novel.new(write_nobel_params)
    @write = user_id = current_user.id
    @write.save
    redirect_to novel_path(@write.id)

  end

  def edit
  end

  def update
  end

  def destroy
  end

  # 投稿データのストロングパラメータ
  private

  def write_nobel_params
    params.require(:novel).permit(:title, :logline, :foreword, :body, :afterword,:novel_status)
  end

end
