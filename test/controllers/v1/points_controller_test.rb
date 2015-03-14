require 'test_helper'

class V1::PointsControllerTest < ActionController::TestCase
  setup do
    @ce = locations(:ce)
    @mg = locations(:mg)
    @pointA = points(:one)
    @pointB = points(:two)
    @pointC = points(:three)
  end

  test 'should route to points' do
    assert_routing '/locations/2/points', { controller: "v1/points", action: "index", location_id: "2" }
  end

  test 'should route to create point' do
    assert_routing({method: 'post', path: '/locations/2/points'}, { controller: "v1/points", action: "create", location_id: "2" })
  end

  test 'should route to point 1' do
    assert_routing '/locations/2/points/1', { controller: "v1/points", action: "show", location_id: "2", id: "1" }
  end

  test 'should route to update point 1' do
    assert_routing({method: 'put', path: '/locations/2/points/1'}, { controller: "v1/points", action: "update", location_id: "2", id: "1" })
  end

  test 'should route to destroy point 1' do
    assert_routing({method: 'delete', path: '/locations/2/points/1'}, { controller: "v1/points", action: "destroy", location_id: "2", id: "1" })
  end

  test "should list points" do
    get :index, location_id: @ce.id
    assert_response :success
    assert_not_nil assigns(:points)
    assert_not_empty assigns(:points)
  end

  test "should not list another location points" do
    get :index, location_id: @ce.id
    assert_response :success
    assert_not_includes assigns(:points), @pointC
  end

  test "should not list points for empty location" do
    get :index, location_id: @mg.id
    assert_response :success
    assert_empty assigns(:points)
  end

  test "should create point" do
    assert_difference('Point.count') do
      post :create, location_id: @ce.id, name: "new #{@pointA.name}"
    end

    assert_response 201
    assert_match(/\/locations\/\d+\/points\/\d+$/, response.location)
  end

  test "should show point" do
    get :show, id: @pointA, location_id: @ce.id
    assert_response :success
  end

  test "should respond not found to show a point that does not exists" do
    get :show, id: @pointA.id+1, location_id: @ce.id
    assert_response :not_found
    assert_nil assigns(:point)
  end

  test "should not show another locations point" do
    get :show, id: @pointC, location_id: @ce.id
    assert_response :not_found
    assert_nil assigns(:point)
  end

  test "should update point" do
    put :update, id: @pointA, location_id: @ce.id, name: @pointA.name
    assert_response 204
  end

  test "should respond not found to update a point that does not exists" do
    put :update, id: @pointA.id+1, location_id: @ce.id, name: @pointA.name
    assert_response 404
    assert_nil assigns(:point)
  end

  test "should not update another locations point" do
    put :update, id: @pointC, location_id: @ce.id, name: @pointC.name
    assert_response 404
    assert_nil assigns(:point)
  end

  test "should destroy point" do
    assert_difference('Point.count', -1) do
      delete :destroy, id: @pointA, location_id: @ce.id
    end

    assert_response 204
  end

  test "a idempotent api should respond no content even if point does not exists" do
    assert_difference('Point.count', 0) do
      delete :destroy, id: @pointA.id+1, location_id: @ce.id
    end

    assert_response 204
  end
end
