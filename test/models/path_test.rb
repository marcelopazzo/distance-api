require 'test_helper'

class PathTest < ActiveSupport::TestCase
  setup do
    @pointA = points(:one)
    @pointB = points(:two)
    @pointC = points(:three)
  end

  test "should not save paths without point1" do
    path = Path.new(point2: @pointB, distance: 10)
    assert_not path.save, "Saved path without point1"
  end

  test "should not save paths without point2" do
    path = Path.new(point1: @pointA, distance: 10)
    assert_not path.save, "Saved path without point2"
  end

  test "should not save paths without distance" do
    path = Path.new(point1: @pointA, point2: @pointB)
    assert_not path.save, "Saved path without distance"
  end

  test "should create path" do
    path = Path.new(point1: @pointA, point2: @pointB, distance: 10)
    assert path.save
  end

  test "should not save paths between points from different locations" do
    path = Path.new(point1: @pointA, point2: @pointC, distance: 10)
    assert_not path.save, "Saved path between points from different locations"
  end
end
