require 'test_helper'

class RestaurantReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restaurant_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get restaurant_reviews_show_url
    assert_response :success
  end

  test "should get new" do
    get restaurant_reviews_new_url
    assert_response :success
  end

  test "should get create" do
    get restaurant_reviews_create_url
    assert_response :success
  end

end
