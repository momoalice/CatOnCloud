require 'test_helper'

class UserAuthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_auth = user_auths(:one)
  end

  test "should get index" do
    get user_auths_url
    assert_response :success
  end

  test "should get new" do
    get new_user_auth_url
    assert_response :success
  end

  test "should create user_auth" do
    assert_difference('UserAuth.count') do
      post user_auths_url, params: { user_auth: { name: @user_auth.name, password: @user_auth.password, user_id: @user_auth.user_id } }
    end

    assert_redirected_to user_auth_url(UserAuth.last)
  end

  test "should show user_auth" do
    get user_auth_url(@user_auth)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_auth_url(@user_auth)
    assert_response :success
  end

  test "should update user_auth" do
    patch user_auth_url(@user_auth), params: { user_auth: { name: @user_auth.name, password: @user_auth.password, user_id: @user_auth.user_id } }
    assert_redirected_to user_auth_url(@user_auth)
  end

  test "should destroy user_auth" do
    assert_difference('UserAuth.count', -1) do
      delete user_auth_url(@user_auth)
    end

    assert_redirected_to user_auths_url
  end
end
