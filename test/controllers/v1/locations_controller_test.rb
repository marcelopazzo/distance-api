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
end
