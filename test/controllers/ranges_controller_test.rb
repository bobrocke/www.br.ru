require "test_helper"

class RangesControllerTest < ActionDispatch::IntegrationTest
  test "should get ranges" do
    get ranges_ranges_url
    assert_response :success
  end
end
