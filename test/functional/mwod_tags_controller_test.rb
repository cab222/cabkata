require 'test_helper'

class MwodTagsControllerTest < ActionController::TestCase
  setup do
    @mwod_tag = mwod_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mwod_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mwod_tag" do
    assert_difference('MwodTag.count') do
      post :create, mwod_tag: { mwod_post_id: @mwod_tag.mwod_post_id, tag: @mwod_tag.tag }
    end

    assert_redirected_to mwod_tag_path(assigns(:mwod_tag))
  end

  test "should show mwod_tag" do
    get :show, id: @mwod_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mwod_tag
    assert_response :success
  end

  test "should update mwod_tag" do
    put :update, id: @mwod_tag, mwod_tag: { mwod_post_id: @mwod_tag.mwod_post_id, tag: @mwod_tag.tag }
    assert_redirected_to mwod_tag_path(assigns(:mwod_tag))
  end

  test "should destroy mwod_tag" do
    assert_difference('MwodTag.count', -1) do
      delete :destroy, id: @mwod_tag
    end

    assert_redirected_to mwod_tags_path
  end
end
