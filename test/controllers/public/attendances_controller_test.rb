require "test_helper"

class Public::AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_attendances_create_url
    assert_response :success
  end
end
