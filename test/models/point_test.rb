require 'test_helper'

class PointTest < ActiveSupport::TestCase
  setup do
    @point = points(:one)
    @location = locations(:rj)
  end

  test "should not save point without name" do
    point = Point.new
    assert_not point.save, "Saved point without a name"
  end

  test "should not allow two points with same name on one location" do
    point = Point.new(name: @point.name, location_id: @point.location_id)
    assert_not point.save, "Saved point with same name of another point in the same location"
  end

  test "should allow two points with same name on different location" do
    point = Point.new(name: @point.name, location_id: @location.id)
    assert point.save
  end

  test "should created point" do
    point = Point.new(name: "E", location_id: @location.id)
    assert point.save
  end

  test "should be searchable by id" do
    @point = points(:one)
    point = Point.find_by_id_or_name(@point.id)
    assert_equal(@point, point)
  end

  test "should be searchable by name" do
    @point = points(:one)
    point = Point.find_by_id_or_name(@point.name)
    assert_equal(@point, point)
  end

end
