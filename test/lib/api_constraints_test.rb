require 'test_helper'

class ApiConstraintsTest < ActiveSupport::TestCase
  Request = Struct.new(:headers)

  setup do
    @simple_request = Request.new()
    @v1_request = Request.new('Accept' => 'application/vnd.distance.v1' )
  end

  test "should match simple request to default" do
    constraint = ApiConstraints.new(version: 548, default: :true)
    assert constraint.matches?(@simple_request)
  end
  
  test "should match v1 request to v1" do
    constraint = ApiConstraints.new(version: 1)
    assert constraint.matches?(@v1_request)
  end

  test "should not match v1 request to v2" do
    constraint = ApiConstraints.new(version: 2)
    assert_not constraint.matches?(@v1_request)
  end
end