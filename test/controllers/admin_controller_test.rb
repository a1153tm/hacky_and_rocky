require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get list_race" do
    get :list_race
    assert_response :success
  end

  test "should get new_race" do
    get :new_race
    assert_response :success
  end

  test "should get create_race" do
    get :create_race
    assert_response :success
  end

  test "should get edit_race" do
    get :edit_race
    assert_response :success
  end

  test "should get update_race" do
    get :update_race
    assert_response :success
  end

  test "should get delete_race" do
    get :delete_race
    assert_response :success
  end

end
