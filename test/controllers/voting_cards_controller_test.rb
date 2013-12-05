require 'test_helper'

class VotingCardsControllerTest < ActionController::TestCase
  setup do
    @race = races(:one)
    @race.genre = genres(:one)
  end

  test "should create_voting_card on vote" do
    user = users(:one)
    session[:user_id] = user.id
    weight = VoteItem::EXPECTATION.keys[0]
    item_count_bef = VoteItem.count
    assert_difference('VotingCard.count', 1) do
      post :vote, {id: @race.id, vote_item: {amount: weight, horse: 1}}
    end
    # assertions of vote item
    item_count_aft = VoteItem.count
    card = VotingCard.find_by(race_id: @race.id, user_id: user.id)
    assert_equal item_count_bef + 1, item_count_aft
    assert_equal 1, card.vote_items.size
    assert_equal 1, card.vote_items.first.race_horse_id
    assert_equal weight, card.vote_items.first.point_weight
    # assertion of response
    assert_redirected_to race_progress_path(@race.id, :current)
  end

=begin
  test "should minus user points on vote" do
    user = users(:one)
    session[:user_id] = user.id
    items = {}
    VoteItem::EXPECTATION.keys.each_with_index {|w,i| items[i + 1] = w}
    item_count_bef = VoteItem.count
    points_bef = user.point
    assert_difference('VotingCard.count', 1) do
      post :vote, {id: @race.id, vote_item: {amount: weight, horse: 1}}
    end
    # assertions of vote item
    item_count_aft = VoteItem.count
    card = VotingCard.find_by(race_id: @race.id, user_id: user.id)
    assert_equal item_count_bef + 3, item_count_aft
    # assetion of user points
    points_aft = points_bef - VoteItem::EXPECTATION.keys.inject(0) {|s,w| s + w}
    assert_equal points_aft, User.find(user.id).point
    # assertion of response
    assert_redirected_to race_progress_path(@race.id, :last)
  end
=end

  test "must login before vote" do
    weight = VoteItem::EXPECTATION.keys[0]
    assert_difference('VotingCard.count', 0) do
      post :vote, {id: @race.id, vote_items: {1 => weight}}
    end
    assert_response :success
    assert_template 'races/show'
  end

  test "must not vote twice" do
    user = users(:one)
    session[:user_id] = user.id
    weight = VoteItem::EXPECTATION.keys[0]
    assert_difference('VotingCard.count', 1) do
      post :vote, {id: @race.id, vote_item: {amount: weight, horse: 1}}
    end
    assert_difference('VotingCard.count', 0) do
      post :vote, {id: @race.id, vote_item: {amount: weight, horse: 1}}
    end
    assert_response :success
    assert_template 'races/show'
  end

end
