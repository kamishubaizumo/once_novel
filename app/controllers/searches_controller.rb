class SearchesController < ApplicationController


  def search

    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])

      #退会していない人を検索する。selectで @usersのuserのis_deleted が有効の人。
      @active_users =  @users.select { |user| user.is_deleted == false}
       render "searches/search_result"
    else




      #byebug
      @novels = Novel.looks(params[:search], params[:word])
      #@novels_public = @novels.reject { |novel| novel.user.is_deleted == true && novel.novel_status == "novels_private"}
      @novels_public = @novels.reject { |novel| novel.novel_status == "novels_private" && novel.user.is_deleted == true || novel.user.is_deleted == false}
      #@novels_public = @novels.reject { |novel| novel.novel_status == "novel_private" } && @active_users =  @users.select { |user| user.is_deleted == false}
       render "searches/search_result"

       #退会者の投稿を自動的に非公開にするには・・・



    end
  end

end



