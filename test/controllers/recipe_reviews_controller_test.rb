require 'test_helper'

class RecipeReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get recipe_reviews_show_url
    assert_response :success
  end

  test "should get new" do
    get recipe_reviews_new_url
    assert_response :success
  end

  test "should get create" do
    get recipe_reviews_create_url
    assert_response :success
  end

  test "should get edit" do
    get recipe_reviews_edit_url
    assert_response :success
  end

  test "should get update" do
    get recipe_reviews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get recipe_reviews_destroy_url
    assert_response :success
  end

end
