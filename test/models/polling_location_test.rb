require "test_helper"

class PollingLocationTest < ActiveSupport::TestCase
  def setup
    @riding = Riding.create!(name: "Test Riding", riding_code: "TR123", province: "Test Province")
    @polling_location = @riding.polling_locations.build(
      title: "Test Location",
      address: "123 Test St",
      city: "Test City",
      postal_code: "A1A 1A1"
    )
  end

  test "should be valid with valid attributes" do
    assert @polling_location.valid?
  end

  test "should be invalid without a title" do
    @polling_location.title = nil
    assert_not @polling_location.valid?
    assert_includes @polling_location.errors[:title], "can't be blank"
  end

  test "should be invalid without an address" do
    @polling_location.address = nil
    assert_not @polling_location.valid?
    assert_includes @polling_location.errors[:address], "can't be blank"
  end

  test "should be invalid without a city" do
    @polling_location.city = nil
    assert_not @polling_location.valid?
    assert_includes @polling_location.errors[:city], "can't be blank"
  end

  test "should be invalid without a postal code" do
    @polling_location.postal_code = nil
    assert_not @polling_location.valid?
    assert_includes @polling_location.errors[:postal_code], "can't be blank"
  end

  test "should be invalid with an incorrect postal code" do
    @polling_location.postal_code = "invalid"
    assert_not @polling_location.valid?
    assert_includes @polling_location.errors[:postal_code], "must be valid"
  end

  test "should be invalid with a duplicate polling location" do
    duplicate_polling_location = @polling_location.dup
    @polling_location.save!
    assert_not duplicate_polling_location.valid?
    assert_includes duplicate_polling_location.errors[:base], "Polling location with the same title, address, city, and postal code already exists for this riding"
  end
end
