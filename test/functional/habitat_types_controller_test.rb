require 'test_helper'

class HabitatTypesControllerTest < ActionController::TestCase
  setup do
    @habitat_type = habitat_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:habitat_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create habitat_type" do
    assert_difference('HabitatType.count') do
      post :create, habitat_type: @habitat_type.attributes
    end

    assert_redirected_to habitat_type_path(assigns(:habitat_type))
  end

  test "should show habitat_type" do
    get :show, id: @habitat_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @habitat_type
    assert_response :success
  end

  test "should update habitat_type" do
    put :update, id: @habitat_type, habitat_type: @habitat_type.attributes
    assert_redirected_to habitat_type_path(assigns(:habitat_type))
  end

  test "should destroy habitat_type" do
    assert_difference('HabitatType.count', -1) do
      delete :destroy, id: @habitat_type
    end

    assert_redirected_to habitat_types_path
  end
end
