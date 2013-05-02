require 'test_helper'

class CoralDemographicsControllerTest < ActionController::TestCase
  setup do
    @coral_demographic = coral_demographics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coral_demographics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coral_demographic" do
    assert_difference('CoralDemographic.count') do
      post :create, coral_demographic: @coral_demographic.attributes
    end

    assert_redirected_to coral_demographic_path(assigns(:coral_demographic))
  end

  test "should show coral_demographic" do
    get :show, id: @coral_demographic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coral_demographic
    assert_response :success
  end

  test "should update coral_demographic" do
    put :update, id: @coral_demographic, coral_demographic: @coral_demographic.attributes
    assert_redirected_to coral_demographic_path(assigns(:coral_demographic))
  end

  test "should destroy coral_demographic" do
    assert_difference('CoralDemographic.count', -1) do
      delete :destroy, id: @coral_demographic
    end

    assert_redirected_to coral_demographics_path
  end
end
