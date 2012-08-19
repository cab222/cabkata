require 'test_helper'

class MwodVideoLinksControllerTest < ActionController::TestCase
  setup do
    @mwod_video_link = mwod_video_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mwod_video_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mwod_video_link" do
    assert_difference('MwodVideoLink.count') do
      post :create, mwod_video_link: { link: @mwod_video_link.link, mwod_post_id: @mwod_video_link.mwod_post_id }
    end

    assert_redirected_to mwod_video_link_path(assigns(:mwod_video_link))
  end

  test "should show mwod_video_link" do
    get :show, id: @mwod_video_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mwod_video_link
    assert_response :success
  end

  test "should update mwod_video_link" do
    put :update, id: @mwod_video_link, mwod_video_link: { link: @mwod_video_link.link, mwod_post_id: @mwod_video_link.mwod_post_id }
    assert_redirected_to mwod_video_link_path(assigns(:mwod_video_link))
  end

  test "should destroy mwod_video_link" do
    assert_difference('MwodVideoLink.count', -1) do
      delete :destroy, id: @mwod_video_link
    end

    assert_redirected_to mwod_video_links_path
  end
end
