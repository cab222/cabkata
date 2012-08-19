require 'test_helper'

class MwodPostsControllerTest < ActionController::TestCase
  setup do
    @mwod_post = mwod_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mwod_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mwod_post" do
    assert_difference('MwodPost.count') do
      post :create, mwod_post: { category: @mwod_post.category, date: @mwod_post.date, title: @mwod_post.title }
    end

    assert_redirected_to mwod_post_path(assigns(:mwod_post))
  end

  test "should show mwod_post" do
    get :show, id: @mwod_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mwod_post
    assert_response :success
  end

  test "should update mwod_post" do
    put :update, id: @mwod_post, mwod_post: { category: @mwod_post.category, date: @mwod_post.date, title: @mwod_post.title }
    assert_redirected_to mwod_post_path(assigns(:mwod_post))
  end

  test "should destroy mwod_post" do
    assert_difference('MwodPost.count', -1) do
      delete :destroy, id: @mwod_post
    end

    assert_redirected_to mwod_posts_path
  end
end
