require "test_helper"

class Public::CommonControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get public_common_top_url
    assert_response :success
  end

  test "should get unauthorized" do
    get public_common_unauthorized_url
    assert_response :success
  end

  test "should get not_found" do
    get public_common_not_found_url
    assert_response :success
  end
end
