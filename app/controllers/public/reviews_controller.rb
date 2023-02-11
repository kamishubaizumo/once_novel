class Public::ReviewsController < ApplicationController

  def index
    @novel = Novel.find(params[:novel_id])

    @review = Review.new
    @reviews = @novel.reviews



  end

  def create


    @review = current_user.reviews.new(review_params)
    @review.novel = Novel.find(params[:novel_id])
    @review.save
    redirect_to novel_reviews_path

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
