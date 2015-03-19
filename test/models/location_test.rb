require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "should not save location without name" do
    location = Location.new
    assert_not location.save, "Saved location without a name"
  end

  test "should not save location with non unique name" do
    @location = locations(:ce)
    location = Location.new(name: @location.name)
    assert_not location.save, "Saved location non unique name"
  end

  test "should create location" do
    location = Location.new(name: "RS")
    assert location.save
  end

  test "should be searchable by id" do
    @location = locations(:ce)
    location = Location.find_by_id_or_name(@location.id)
    assert_equal(@location, location)
  end

  test "should be searchable by name" do
    @location = locations(:ce)
    location = Location.find_by_id_or_name(@location.name)
    assert_equal(@location, location)
  end
end
