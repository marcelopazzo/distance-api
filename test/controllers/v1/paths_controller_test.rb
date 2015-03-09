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

  test "should get index" do
    get :index, location_id: @ce.id
    assert_response :success
    assert_not_nil assigns(:paths)
    assert_not_empty assigns(:paths)
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

  test "should update path" do
    put :update, id: @path, location_id: @ce.id, distance: @path.distance, point1_id: @path.point1_id, point2_id: @path.point2_id
    assert_response 204
  end

  test "should destroy path" do
    assert_difference('Path.count', -1) do
      delete :destroy, id: @path, location_id: @ce.id
    end

    assert_response 204
  end
end
