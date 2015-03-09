require 'priority_queue'

class Graph
  Edge = Struct.new(:source, :destination, :weight)

  attr_reader :vertices, :edges
  attr_accessor :distances, :previous, :priority_queue, :path

  def initialize(points, paths)
    @vertices = points.collect &:name
    @edges = paths.collect { |p| Edge.new(p.point1.name, p.point2.name, p.distance) }
    @distances = {}
    @previous = {}
    @priority_queue = PriorityQueue.new
    @path = []
  end

  def initialize_single_source(source)
    vertices.each do |vertex|
      distances[vertex] = BigDecimal::INFINITY
      previous[vertex] = nil
    end
    distances[source] = 0
  end

  def relax_edge(edge)
    source      = edge.source
    destination = edge.destination
    weight      = edge.weight

    if (distances[destination] > distances[source] + weight)
      distances[destination] = distances[source] + weight
      previous[destination] = source
      priority_queue[destination] = distances[destination]
    end
  end

  def adjacents(vertex)
    edges.select {|p| p.source == vertex or p.destination == vertex}
  end

  def shortest_path(source, target)
    source = source.name if source.is_a? Point
    target = target.name if target.is_a? Point
    initialize_single_source(source)
    dijkstras(source, target)
    [path.reverse, distances[target]]
  end

  def dijkstras(source, target)
    if source == target
      previous_vertex = target
      while(previous_vertex != nil)
        path << previous_vertex
        previous_vertex = previous[previous_vertex]
      end
    else
      adjacents(source).each do |e|
        relax_edge(e)
      end
      dijkstras(priority_queue.delete_min_return_key, target)
    end
  end

end