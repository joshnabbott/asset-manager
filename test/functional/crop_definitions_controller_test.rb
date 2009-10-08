require 'test_helper'

class CropDefinitionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crop_definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crop_definition" do
    assert_difference('CropDefinition.count') do
      post :create, :crop_definition => { }
    end

    assert_redirected_to crop_definition_path(assigns(:crop_definition))
  end

  test "should show crop_definition" do
    get :show, :id => crop_definitions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => crop_definitions(:one).to_param
    assert_response :success
  end

  test "should update crop_definition" do
    put :update, :id => crop_definitions(:one).to_param, :crop_definition => { }
    assert_redirected_to crop_definition_path(assigns(:crop_definition))
  end

  test "should destroy crop_definition" do
    assert_difference('CropDefinition.count', -1) do
      delete :destroy, :id => crop_definitions(:one).to_param
    end

    assert_redirected_to crop_definitions_path
  end
end
