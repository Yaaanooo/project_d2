require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get admin_list_url
    assert_response :success
  end

  test "should get new" do
    get admin_new_url
    assert_response :success
  end

  test "should get genre" do
    get admin_genre_url
    assert_response :success
  end
end
