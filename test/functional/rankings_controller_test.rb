require 'test_helper'

class RankingsControllerTest < ActionController::TestCase
  setup do
    @ranking = rankings(:one)
  end

  test "should get fetch" do
    get :fetch
    assert_response :success
  end

end
