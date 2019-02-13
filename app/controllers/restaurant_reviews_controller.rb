class RestaurantReviewsController < ApplicationController
  def index
    @restaurant_reviews = RestaurantReview.all
  end

  def show
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_review = RestaurantReview.new
  end

  def create
    @restaurant_review = RestaurantReview.new(review_params)
    # we need `restaurant_id` to asssociate review with corresponding restaurant
    @restaurant_review.restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant_review.save
      @restaurant_review.save
      redirect_to restaurant_path(@restaurant_review.restaurant)
    else
      render :new
   end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @restaurant_review = RestaurantReview.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:restaurant_review).permit(:content, :rating, :restaurant_id)
  end
end
