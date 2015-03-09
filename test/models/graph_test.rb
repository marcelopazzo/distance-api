require 'test_helper'

class GraphTest < ActiveSupport::TestCase
  setup do
    @sp = locations(:sp)
    @source = points(:a)
    @destination = points(:d)
    @g = Graph.new(@sp.points, @sp.paths)
  end

  test "should initialize vertices" do
    @sp.points.map(&:name).each do |v|
      assert_includes(@g.vertices, v)
    end
  end

  test "should initialize_single_source" do
    source = "A"
    @g.initialize_single_source(source)
    assert_equal(0, @g.distances[source])

    @sp.points.map(&:name).each do |v|
      assert_equal(BigDecimal::INFINITY, @g.distances[v]) unless v == source
      assert_equal(nil, @g.previous[v])
    end
  end

  test "should calculate successfully" do
    source = @source.name
    destination = @destination.name

    path, distance = @g.shortest_path(source, destination)
    assert_equal(25, distance)
    assert_equal(["A", "B", "D"], path)
  end

end