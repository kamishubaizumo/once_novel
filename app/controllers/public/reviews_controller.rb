class Public::ReviewsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]


  def index
    @novel = Novel.find(params[:novel_id])

    @review = Review.new
    @reviews = @novel.reviews



  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.novel_id= Novel.find(params[:novel_id]).id

    review_count = Review.where(novel_id: params[:novel_id]).where(user_id: current_user.id).count


    #バリデート判定
    if @review.valid?
    #感想は一度だけ
      if review_count < 1

        @review.save
        flash[:notice] = "投稿に成功しました"
      redirect_to novel_reviews_path
      else
       flash[:notice] = "投稿に失敗しました。過去の感想を削除してください"
      redirect_to novel_reviews_path

      end
    else
      flash[:notice] = "投稿に失敗しました。2文字以上で投稿してください"
      redirect_to novel_reviews_path
    end

  end

  def destroy
    @review = Review.find(params[:id]).destroy
    flash[:notice] = "削除しました"
    redirect_to novel_reviews_path

  end


    private

  def review_params
    params.require(:review).permit(:comment,:star_rate, :novel_id)
  end


    #他人の感想を削除をできないようにする
  def is_matching_login_user
    @review = Review.find(params[:id])

    unless @review.user == current_user
      flash[:notice] = "他人の投稿は削除できません"
      redirect_to action: :index
    end

  end


end
