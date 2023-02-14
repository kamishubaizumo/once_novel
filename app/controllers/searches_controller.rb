class SearchesController < ApplicationController


  def search

    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
       render "searches/search_result"
    else
      @novels = Novel.looks(params[:search], params[:word])
       render "searches/search_result"
    end
  end

end
