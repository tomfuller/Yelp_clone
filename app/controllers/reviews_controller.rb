class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    if @review.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
