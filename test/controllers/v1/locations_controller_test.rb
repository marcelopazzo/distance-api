require 'test_helper'

class V1::LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:sp)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, name: @location.name
    end

    assert_response 201
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should update location" do
    put :update, id: @location, name: @location.name
    assert_response 204
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_response 204
  end
end
