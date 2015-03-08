require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "should not save point without name" do
    point = Point.new
    assert_not point.save, "Saved point without a name"
  end

  test "should not allow two points with same name on one location" do
    @point = points(:one)
    point = Point.new(name: @point.name, location_id: @point.location_id)
    assert_not point.save, "Saved point with same name of another point in the same location"
  end

  test "should allow two points with same name on different location" do
    @point = points(:one)
    @other_location = locations(:rj)
    point = Point.new(name: @point.name, location_id: @other_location.id)
    assert point.save
  end
end
