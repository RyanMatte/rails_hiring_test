require "test_helper"

class PollingLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @riding = ridings(:one)
    @polling_location = polling_locations(:one)
  end

  test "should get edit" do
    get edit_riding_polling_location_url(@riding, @polling_location)
    assert_response :success
  end

  test "should update polling_location" do
    patch riding_polling_location_url(@riding, @polling_location), params: { polling_location: { title: "Updated Title", address: "Updated Address", city: "Updated City", postal_code: "A1A 1A1" } }
    assert_redirected_to riding_path(@riding)
    @polling_location.reload
    assert_equal "Updated Title", @polling_location.title
    assert_equal "Updated Address", @polling_location.address
    assert_equal "Updated City", @polling_location.city
    assert_equal "A1A 1A1", @polling_location.postal_code
  end

  test "should not update polling_location with invalid data" do
    patch riding_polling_location_url(@riding, @polling_location), params: { polling_location: { title: "", address: "", city: "", postal_code: "" } }
    assert_response :unprocessable_entity
  end
end