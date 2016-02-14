require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :redirect
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "admin user should destroy post" do
    sign_in users(:admin)
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end

  # destroy

  test "common user should not destroy post" do
    sign_in users(:common)
    assert_difference('Post.count', 0) do
      delete :destroy, id: @post
    end
    assert_response :forbidden
  end

  test "not logged in user should be redirected to login" do
    delete :destroy, id: @post
    assert_difference('Post.count', 0) do
      delete :destroy, id: @post
    end
    assert_redirected_to new_user_session_path
  end

  # create

  test "admin user should create post" do
    sign_in users(:admin)
    assert_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
    end
    assert_redirected_to post_path(assigns(:post))
  end

  test "common user should not create post" do
    sign_in users(:common)
    assert_difference('Post.count', 0) do
      post :create, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
    end
    assert_response :forbidden
  end

  test "not logged in user should be redirected to login on creation" do
    post :create, id: @post
    assert_difference('Post.count', 0) do
      post :create, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
    end
    assert_redirected_to new_user_session_path
  end


  # update

  test "admin should get edit" do
    sign_in users(:admin)
    get :edit, id: @post
    assert_response :success
  end

  test "common user should get edit" do
    sign_in users(:common)
    get :edit, id: @post
    assert_response :forbidden
  end

  test "not logged in should not get edit" do
    get :edit, id: @post
    assert_response :redirect
  end

  test "admin user should update post" do
    sign_in users(:admin)
    patch :update, id: @post, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
    assert_redirected_to post_path(assigns(:post))
  end

  test "common user should not update post" do
    sign_in users(:common)
    patch :update, id: @post, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
  end

  test "not logged in user should not update post" do
    patch :update, id: @post, post: { body: @post.body, title: @post.title, user_id: @post.user_id }
    assert_redirected_to new_user_session_path
  end

end
