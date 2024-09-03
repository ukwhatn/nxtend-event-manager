require "test_helper"

class Public::ProgramsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_programs_show_url
    assert_response :success
  end
end
