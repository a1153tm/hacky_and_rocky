require 'test_helper'

class VotingCardTest < ActiveSupport::TestCase

  test "voting_card attributes must not be empty" do
    card = VotingCard.new
    assert card.invalid?
    assert card.errors[:race_id].any?
    assert card.errors[:vote_date].any?
    assert card.errors[:user_id].any?
    assert card.errors[:vote_items].any?
  end

  test "voting_card must have one vote_item at least" do
    card = VotingCard.new(race_id: 1, vote_date: Time.now, user_id: 1, vote_items: [])
    assert card.invalid?
    assert card.errors[:vote_items].any?
  end

  test "voting_card must have honmei" do
    honmei = VoteItem::EXPECTATION.first[0]
    item = VoteItem.new(race_horse_id: 1, point_weight: VoteItem::EXPECTATION.keys[1])
    card = VotingCard.new(race_id: 1, vote_date: Time.now, user_id: 1)
    card.vote_items << item
    assert card.invalid?
    assert card.errors[:vote_items].any?
    item = VoteItem.new(race_horse_id: 1, point_weight: VoteItem::EXPECTATION.keys[0])
    card.vote_items << item
    assert card.valid?
  end

  test "vote_items in voting_card must be uniq" do
    honmei = VoteItem::EXPECTATION.first[0]
    card = VotingCard.new(race_id: 1, vote_date: Time.now, user_id: 1)
    card.vote_items << VoteItem.new(race_horse_id: 1, point_weight: VoteItem::EXPECTATION.keys[0])
    card.vote_items << VoteItem.new(race_horse_id: 2, point_weight: VoteItem::EXPECTATION.keys[0])
    assert card.invalid?
    assert card.errors[:vote_items].any?
  end

end
