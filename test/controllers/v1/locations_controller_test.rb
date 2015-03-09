require 'test_helper'

class V1::LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:ce)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
    assert_not_empty assigns(:locations)
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, name: "new #{@location.name}"
    end

    assert_response 201
    assert_match(/\/locations\/\d+$/, response.location)
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should respond not found to show a location that does not exists" do
    get :show, id: @location.id+1
    assert_response :not_found
    assert_nil assigns(:location)
  end

  test "should update location" do
    put :update, id: @location, name: @location.name
    assert_response 204
  end

  test "should respond not found to update a location that does not exists" do
    get :update, id: @location.id+1, name: @location.name
    assert_response :not_found
    assert_nil assigns(:location)
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_response 204
  end

  test "a idempotent api should respond no content even if location does not exists" do
    assert_difference('Location.count', 0) do
      delete :destroy, id: @location.id+1
    end

    assert_response 204
  end

  test "should show location graph" do
    @sp = locations(:sp)
    @source = points(:a)
    @destination = points(:d)
    get :best_route, id: @sp, source_id: @source.id, destination_id: @destination.id,
      autonomy: 10, fuel_price: 2.5

    result = JSON::parse(response.body)
    assert_equal("6.25", result["cost"])
    assert_equal(["A", "B", "D"], result["path"])
    assert_response :ok
  end

  test "should not calculate route for points in different maps" do
    @sp = locations(:sp)
    @source = points(:a)
    @destination = points(:two)
    get :best_route, id: @sp, source_id: @source.id, destination_id: @destination.id,
      autonomy: 10, fuel_price: 2.5

    assert_response :bad_request
  end

  test "should not break if we forget a param" do
    @sp = locations(:sp)
    get :best_route, id: @sp
    assert_response :bad_request
  end

end
