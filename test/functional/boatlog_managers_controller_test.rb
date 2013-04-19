require 'test_helper'

class BoatlogManagersControllerTest < ActionController::TestCase
  setup do
    @boatlog_manager = boatlog_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boatlog_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boatlog_manager" do
    assert_difference('BoatlogManager.count') do
      post :create, boatlog_manager: @boatlog_manager.attributes
    end

    assert_redirected_to boatlog_manager_path(assigns(:boatlog_manager))
  end

  test "should show boatlog_manager" do
    get :show, id: @boatlog_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boatlog_manager
    assert_response :success
  end

  test "should update boatlog_manager" do
    put :update, id: @boatlog_manager, boatlog_manager: @boatlog_manager.attributes
    assert_redirected_to boatlog_manager_path(assigns(:boatlog_manager))
  end

  test "should destroy boatlog_manager" do
    assert_difference('BoatlogManager.count', -1) do
      delete :destroy, id: @boatlog_manager
    end

    assert_redirected_to boatlog_managers_path
  end
end
