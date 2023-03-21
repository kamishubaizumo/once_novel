class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new




  # ジャンルの横にカウントを表示させたい。

  end

  def create
    genre = Genre.new(genre_params)
     if genre.save
       redirect_to admin_genres_path
       flash[:notice] = "追加しました"
     else
       @genres = Genre.all
       @genre = Genre.new
       render :index
       flash[:notice] = "追加に失敗しました"
     end


  end



  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
      if genre.update(genre_params)
        redirect_to admin_genres_path
        flash[:notice] = "更新しました"
      else
        @genre = Genre.find(params[:id])
        render "edit"
        flash[:notice] = "更新に失敗しました"
      end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

  private

   def genre_params
    params.require(:genre).permit(:genre)
   end
end
