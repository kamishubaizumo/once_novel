class Public::ReviewsController < ApplicationController

  def index
    @novel = Novel.find(params[:novel_id])

    @review = Review.new
    @reviews = @novel.reviews



  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.novel_id= Novel.find(params[:novel_id]).id
    if  @review.save
      flash[:notice] = "投稿に成功しました"
    redirect_to novel_reviews_path
    else
     flash[:notice] = "投稿できませんでした"
     render novel_review_path(@review.id)
    end
  end

  def destroy
    @review = Review.find(params[:id]).destroy
    redirect_to novel_reviews_path

  end


    private

  def review_params
    params.require(:review).permit(:comment,:star_rate, :novel_id)
  end

end
