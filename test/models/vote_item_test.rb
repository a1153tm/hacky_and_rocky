require 'test_helper'

class VoteItemTest < ActiveSupport::TestCase

  test "vote_item attributes must not be empty" do
    item = VoteItem.new
    assert item.invalid?
    assert item.errors[:race_horse_id].any?
    assert item.errors[:point_weight].any?
  end

  test "point weight must be included in VoteItem::EXPECTATION" do
    item = VoteItem.new(race_horse_id: 1, point_weight: 999)
    assert item.invalid?
    assert item.errors[:point_weight].any?
  end

end
