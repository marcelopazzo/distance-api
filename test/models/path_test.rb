require 'test_helper'

class PathTest < ActiveSupport::TestCase
  setup do
    @pointA = points(:one)
    @pointB = points(:four)
    @pointC = points(:three)
    @path = paths(:one)
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

  test "should not save paths that already exists" do
    path = Path.new(point1: @path.point1, point2: @path.point2, distance: 10)
    assert_not path.save, "Saved path that already exists"
  end

  test "should not save paths that already exists in the other direction" do
    path = Path.new(point1: @path.point2, point2: @path.point1, distance: 10)
    assert_not path.save, "Saved path that already exists in the other direction"
  end
end
