require 'test_helper'

class AssetCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_category" do
    assert_difference('AssetCategory.count') do
      post :create, :asset_category => { }
    end

    assert_redirected_to asset_category_path(assigns(:asset_category))
  end

  test "should show asset_category" do
    get :show, :id => asset_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => asset_categories(:one).to_param
    assert_response :success
  end

  test "should update asset_category" do
    put :update, :id => asset_categories(:one).to_param, :asset_category => { }
    assert_redirected_to asset_category_path(assigns(:asset_category))
  end

  test "should destroy asset_category" do
    assert_difference('AssetCategory.count', -1) do
      delete :destroy, :id => asset_categories(:one).to_param
    end

    assert_redirected_to asset_categories_path
  end
end
