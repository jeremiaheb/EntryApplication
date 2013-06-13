require 'test_helper'

class BoatLogsControllerTest < ActionController::TestCase
  setup do
    @boat_log = boat_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boat_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boat_log" do
    assert_difference('BoatLog.count') do
      post :create, boat_log: @boat_log.attributes
    end

    assert_redirected_to boat_log_path(assigns(:boat_log))
  end

  test "should show boat_log" do
    get :show, id: @boat_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boat_log
    assert_response :success
  end

  test "should update boat_log" do
    put :update, id: @boat_log, boat_log: @boat_log.attributes
    assert_redirected_to boat_log_path(assigns(:boat_log))
  end

  test "should destroy boat_log" do
    assert_difference('BoatLog.count', -1) do
      delete :destroy, id: @boat_log
    end

    assert_redirected_to boat_logs_path
  end
end
