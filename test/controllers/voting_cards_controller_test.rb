require 'test_helper'

class RacesControllerTest < ActionController::TestCase
  setup do
    @race = races(:one)
  end

  test "should create_voting_card index" do
    post :vote, {id: @race.id, vote_items: {1 => 2}
    assert_response :success
    assert_not_nil assigns(:races)
  end

end
