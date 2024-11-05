require "test_helper"

class RidingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @riding = ridings(:one)
  end

  test "should show riding" do
    get riding_url(@riding)
    assert_response :success
  end
end
