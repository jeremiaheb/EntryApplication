require 'test_helper'

class DiversControllerTest < ActionController::TestCase
  setup do
    @diver = divers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:divers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diver" do
    assert_difference('Diver.count') do
      post :create, diver: @diver.attributes
    end

    assert_redirected_to diver_path(assigns(:diver))
  end

  test "should show diver" do
    get :show, id: @diver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diver
    assert_response :success
  end

  test "should update diver" do
    put :update, id: @diver, diver: @diver.attributes
    assert_redirected_to diver_path(assigns(:diver))
  end

  test "should destroy diver" do
    assert_difference('Diver.count', -1) do
      delete :destroy, id: @diver
    end

    assert_redirected_to divers_path
  end
end
