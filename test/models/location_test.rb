require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "should not save location without name" do
    location = Location.new
    assert_not location.save, "Saved location without a name"
  end

  test "location name should be unique" do
    @location = locations(:sp)
    location = Location.new(name: @location.name)
    assert_not location.save, "Saved location non unique name"
  end
end
