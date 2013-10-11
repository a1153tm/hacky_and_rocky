require 'test_helper'

class RaceHorsesControllerTest < ActionController::TestCase
  setup do
    @race_horse = race_horses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:race_horses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race_horse" do
    assert_difference('RaceHorse.count') do
      post :create, race_horse: { book_id: @race_horse.book_id, comment: @race_horse.comment, house_no: @race_horse.house_no, race_id: @race_horse.race_id }
    end

    assert_redirected_to race_horse_path(assigns(:race_horse))
  end

  test "should show race_horse" do
    get :show, id: @race_horse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race_horse
    assert_response :success
  end

  test "should update race_horse" do
    patch :update, id: @race_horse, race_horse: { book_id: @race_horse.book_id, comment: @race_horse.comment, house_no: @race_horse.house_no, race_id: @race_horse.race_id }
    assert_redirected_to race_horse_path(assigns(:race_horse))
  end

  test "should destroy race_horse" do
    assert_difference('RaceHorse.count', -1) do
      delete :destroy, id: @race_horse
    end

    assert_redirected_to race_horses_path
  end
end
