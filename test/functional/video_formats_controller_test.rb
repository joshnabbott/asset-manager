require 'test_helper'

class VideoFormatsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_formats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_format" do
    assert_difference('VideoFormat.count') do
      post :create, :video_format => { }
    end

    assert_redirected_to video_format_path(assigns(:video_format))
  end

  test "should show video_format" do
    get :show, :id => video_formats(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => video_formats(:one).to_param
    assert_response :success
  end

  test "should update video_format" do
    put :update, :id => video_formats(:one).to_param, :video_format => { }
    assert_redirected_to video_format_path(assigns(:video_format))
  end

  test "should destroy video_format" do
    assert_difference('VideoFormat.count', -1) do
      delete :destroy, :id => video_formats(:one).to_param
    end

    assert_redirected_to video_formats_path
  end
end
