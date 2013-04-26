require 'test_helper'

class BenthicCoversControllerTest < ActionController::TestCase
  setup do
    @benthic_cover = benthic_covers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:benthic_covers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create benthic_cover" do
    assert_difference('BenthicCover.count') do
      post :create, benthic_cover: @benthic_cover.attributes
    end

    assert_redirected_to benthic_cover_path(assigns(:benthic_cover))
  end

  test "should show benthic_cover" do
    get :show, id: @benthic_cover
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @benthic_cover
    assert_response :success
  end

  test "should update benthic_cover" do
    put :update, id: @benthic_cover, benthic_cover: @benthic_cover.attributes
    assert_redirected_to benthic_cover_path(assigns(:benthic_cover))
  end

  test "should destroy benthic_cover" do
    assert_difference('BenthicCover.count', -1) do
      delete :destroy, id: @benthic_cover
    end

    assert_redirected_to benthic_covers_path
  end
end
