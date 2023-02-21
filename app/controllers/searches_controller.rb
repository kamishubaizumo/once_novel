class SearchesController < ApplicationController


  def search

    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])

      #退会していない人を検索する。selectで @usersのuserのis_deleted が有効の人。
      @active_users =  @users.select { |user| user.is_deleted == false}
       render "searches/search_result"
    else


      @novels = Novel.looks(params[:search], params[:word])
      #@novels_public = @novels.reject { |novel| novel.user.is_deleted == true && novel.novel_status == "novels_private"}
      @novels_public = @novels.reject { |novel| novel.novel_status == "novel_private" }
      #@novels_public = @novels.reject { |novel| novel.novel_status == "novel_private" } && @active_users =  @users.select { |user| user.is_deleted == false}
       render "searches/search_result"



    end
  end

end




