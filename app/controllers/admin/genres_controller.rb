class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new

  end

  def create
    genre = Genre.new(genre_params)
     if
     end
    
    
  end

  def edit
    @genres = Genre.find(params[:id])
  end

  def update
  end

  private

   def genre_params
    params.require(:genre).permit(:genre)
   end
end
