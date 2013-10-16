require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    @race = races(:one)
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get list_race" do
    #get :list_race
    #assert_response :success
  end

  test "should get new_race" do
    get :new_race
    assert_response :success
  end

  test "should create race" do
   #assert_difference('Race.count') do
   #   post :create_race, race: { end_date: @race.end_date, etype: @race.etype, grade: @race.grade, name: @race.name, start_date: @race.start_date }
   #end
  end

  test "should get edit_race" do
    #get :edit_race, id: 1
    #assert_response :success
  end

  test "should get update_race" do
    #get :update_race
    #assert_response :success
  end

  test "should get delete_race" do
    #get :delete_race
    #assert_response :success
  end

end
