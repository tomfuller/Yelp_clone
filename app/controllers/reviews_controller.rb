class ReviewsController < ApplicationController

  def new
    user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = user.reviews.new
  end

  def create
    user = current_user
    p user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)

    if @review.save
          p @review
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
