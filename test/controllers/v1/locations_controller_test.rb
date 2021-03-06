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

  test 'should route to locations' do
    assert_routing '/locations', { controller: "v1/locations", action: "index" }
  end

  test 'should route to create location' do
    assert_routing({method: 'post', path: '/locations'}, { controller: "v1/locations", action: "create" })
  end

  test 'should route to location 1' do
    assert_routing '/locations/1', { controller: "v1/locations", action: "show", id: "1" }
  end

  test 'should route to update location 1' do
    assert_routing({method: 'put', path: '/locations/1'}, { controller: "v1/locations", action: "update", id: "1" })
  end

  test 'should route to destroy location 1' do
    assert_routing({method: 'delete', path: '/locations/1'}, { controller: "v1/locations", action: "destroy", id: "1" })
  end

  test 'should route location 1 best_route' do
    assert_routing '/locations/1/best_route', { controller: "v1/locations", action: "best_route", id: "1" }
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, name: "new #{@location.name}"
    end

    assert_response 201
    assert_match(/\/locations\/\d+$/, response.location)
  end

  test "should not create location without name" do
    assert_difference('Location.count', 0) do
      post :create, name: ""
    end

    assert_response 422
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
    assert_not_nil assigns(:location)
  end

  test "should respond not found to show a location that does not exists" do
    get :show, id: @location.id+1
    assert_response :not_found
    assert_nil assigns(:location)
  end

  test "should also show location by name" do
    get :show, id: @location.name
    assert_response :success
    assert_not_nil assigns(:location)
  end

  test "should work with numeric names" do
    numeric_location = locations(:numeric_name)
    get :show, id: numeric_location.name
    assert_response :success
    assert_not_nil assigns(:location)
  end

  test "should update location" do
    put :update, id: @location, name: @location.name
    assert_response 204
  end

  test "should not update location without name" do
    put :update, id: @location, name: ""
    assert_response 422
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
