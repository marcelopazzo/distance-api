require 'test_helper'

class V1::PathsControllerTest < ActionController::TestCase
  setup do
    @ce = locations(:ce)
    @mg = locations(:mg)
    @pointA = points(:one)
    @pointB = points(:two)
    @pointC = points(:three)
    @pointD = points(:four)
    @path = paths(:one)
  end

  test 'should route to paths' do
    assert_routing '/locations/2/paths', { controller: "v1/paths", action: "index", location_id: "2" }
  end

  test 'should route to create path' do
    assert_routing({method: 'post', path: '/locations/2/paths'}, { controller: "v1/paths", action: "create", location_id: "2" })
  end

  test 'should route to path 1' do
    assert_routing '/locations/2/paths/1', { controller: "v1/paths", action: "show", location_id: "2", id: "1" }
  end

  test 'should route to update path 1' do
    assert_routing({method: 'put', path: '/locations/2/paths/1'}, { controller: "v1/paths", action: "update", location_id: "2", id: "1" })
  end

  test 'should route to destroy path 1' do
    assert_routing({method: 'delete', path: '/locations/2/paths/1'}, { controller: "v1/paths", action: "destroy", location_id: "2", id: "1" })
  end

  test "should get index" do
    get :index, location_id: @ce.id
    assert_response :success
    assert_not_nil assigns(:paths)
    assert_not_empty assigns(:paths)
  end

  test "should not list another location paths" do
    get :index, location_id: @mg.id
    assert_response :success
    assert_not_includes assigns(:paths), @path
    assert_empty assigns(:paths)
  end

  test "should create path" do
    assert_difference('Path.count') do
      post :create, location_id: @ce.id, distance: 5, point1_id: @pointA.id, point2_id: @pointD.id
    end

    assert_response 201
    assert_match(/\/locations\/\d+\/paths\/\d+$/, response.location)
  end

  test "should show path" do
    get :show, id: @path, location_id: @ce.id
    assert_response :success
  end

  test "should respond not found to show a path that does not exists" do
    get :show, id: @path.id+1, location_id: @ce.id
    assert_response :not_found
    assert_nil assigns(:path)
  end

  test "should not show another locations path" do
    get :show, id: @path, location_id: @mg.id
    assert_response :not_found
    assert_nil assigns(:point)
  end

  test "should update path" do
    put :update, id: @path, location_id: @ce.id, distance: @path.distance, point1_id: @path.point1_id, point2_id: @path.point2_id
    assert_response 204
  end

  test "should respond not found to update a path that does not exists" do
    put :update, id: @path.id+1, location_id: @ce.id, distance: @path.distance, point1_id: @path.point1_id, point2_id: @path.point2_id
    assert_response 404
    assert_nil assigns(:path)
  end

  test "should not update another locations path" do
    put :update, id: @path, location_id: @mg.id, distance: @path.distance, point1_id: @path.point1_id, point2_id: @path.point2_id
    assert_response 404
    assert_nil assigns(:path)
  end

  test "should destroy path" do
    assert_difference('Path.count', -1) do
      delete :destroy, id: @path, location_id: @ce.id
    end

    assert_response 204
  end

  test "a idempotent api should respond no content even if path does not exists" do
    assert_difference('Path.count', 0) do
      delete :destroy, id: @path.id+1, location_id: @ce.id
    end

    assert_response 204
  end
end
