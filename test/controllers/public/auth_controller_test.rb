require "test_helper"

class Public::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get create_token_for_discord" do
    get public_auth_create_token_for_discord_url
    assert_response :success
  end

  test "should get sign_in_with_discord" do
    get public_auth_sign_in_with_discord_url
    assert_response :success
  end
end
