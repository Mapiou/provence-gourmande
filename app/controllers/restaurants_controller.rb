class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.where.not(latitude: nil, longitude: nil)
    @restaurants = @restaurants.near(params[:city], 5) if params[:city].present?
    @markers = @restaurants.map do |restaurant|
      {
        lng: restaurant.longitude,
        lat: restaurant.latitude
      }
    end
  end

  def show
    @restaurant_reviews = RestaurantReview.select {|review| review.restaurant_id == @restaurant.id}
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    # respond_to do |format|
    #   if @restaurant.save
    #     format.html { redirect_to restaurant_path(@restaurant), notice: 'Restaurant was successfully created.' }
    #     format.json { render :show, status: :created, location: @restaurant }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @restaurant.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    # respond_to do |format|
    #   if @restaurant.update(restaurant_params)
    #     format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @restaurant }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @restaurant.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @restaurant.destroy
    # respond_to do |format|
    #   format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone, :price, :photo, :description)
  end
end
