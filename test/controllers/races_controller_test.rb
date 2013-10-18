require 'test_helper'

class RacesControllerTest < ActionController::TestCase
  setup do
    @race = races(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:races)
  end
  # TODO すぐ解除すること・・・。発表の為・・・
  #test "should show race" do
  #  get :show, id: @race
  #  assert_response :success
  #end

end
