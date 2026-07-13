require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get game_top_url
    assert_response :success
  end

  test "should get quiz" do
    get game_quiz_url
    assert_response :success
  end

  test "should get result" do
    get game_result_url
    assert_response :success
  end
end
