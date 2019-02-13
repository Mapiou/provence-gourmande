class RecipeReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_review = RecipeReview.new(recipe_review_params)
    @recipe_review.recipe = @recipe
    if @recipe_review.save
      redirect_to recipe_path(@recipe)
    else
      @dose = Dose.new
      render "recipe_review/show"
    end
  end

  private

  def recipe_review_params
    params.require(:recipe_review).permit(:rating, :content)
  end
end
